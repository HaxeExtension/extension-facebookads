package extension.facebookads;
import openfl.utils.JNI;
import openfl.Lib;

class FacebookAds {
	private static var initialized:Bool = false;
	private static var testingAds:Bool=false;

	private static var __showInterstitial:Void->Void = function(){}

	///////////////////////////////////////////////////////////////////////////
	///////////////////////////////////////////////////////////////////////////

	public static function enableTestingAds() {
		if ( testingAds ) return;
		if ( initialized ) {
			var msg:String;
			msg = "FATAL ERROR: If you want to enable Testing Ads, you must enable them before calling INIT!.\n";
			msg+= "Throwing an exception to avoid displaying read ads when you want testing ads.";
			trace(msg);
			throw msg;
			return;
		}
		testingAds = true;
	}

	///////////////////////////////////////////////////////////////////////////
	///////////////////////////////////////////////////////////////////////////

	public static function init(interstitialID:String){
		if(initialized) return;
		try{
			var __init:Bool->FacebookAds->String->Void;

			trace("init 1");
			__init = JNI.createStaticMethod("org/haxe/extension/facebookAds/FacebookAds","init","(ZLorg/haxe/lime/HaxeObject;Ljava/lang/String;)V");
			trace("init 2");
			__showInterstitial = JNI.createStaticMethod("org/haxe/extension/facebookAds/FacebookAds", "showInterstitial", "()V");
			trace("init 3");

			initialized = true;
			__init(testingAds,null,interstitialID);
			trace("init 4");

		}catch(e:Dynamic){
			trace("Error: "+e);
		}
	}

	////////////////////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////


	private static var lastTimeInterstitial:Int = -60*1000;
	private static var displayCallsCounter:Int = 0;
	
	public static function showInterstitial(minInterval:Int=60, minCallsBeforeDisplay:Int=0) {
		displayCallsCounter++;
		if( (Lib.getTimer()-lastTimeInterstitial)<(minInterval*1000) ) return;
		if( minCallsBeforeDisplay > displayCallsCounter ) return;
		displayCallsCounter = 0;
		lastTimeInterstitial = Lib.getTimer();
		try{
			__showInterstitial();
		}catch(e:Dynamic){
			trace("ShowInterstitial Exception: "+e);
		}
	}

	////////////////////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////

}