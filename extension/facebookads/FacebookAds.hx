package extension.facebookads;
import openfl.utils.JNI;
import openfl.Lib;

class FacebookAds {
	private static var initialized:Bool = false;
	private static var testingAds:Bool=false;

	private static var __showInterstitial:Void->Bool = function() {return false;}
	public static var showBanner:Void->Void = function() {}
	public static var hideBanner:Void->Void = function() {}

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

	public static function init(bannerID:String,interstitialID:String) {
		if(initialized) return;
		try {
			var __init:Bool->FacebookAds->String->String->Void;
			__init = JNI.createStaticMethod("org/haxe/extension/facebookAds/FacebookAds","init","(ZLorg/haxe/lime/HaxeObject;Ljava/lang/String;Ljava/lang/String;)V");
			__showInterstitial = JNI.createStaticMethod("org/haxe/extension/facebookAds/FacebookAds", "showInterstitial", "()Z");
			showBanner = JNI.createStaticMethod("org/haxe/extension/facebookAds/FacebookAds", "showBanner", "()V");
			hideBanner = JNI.createStaticMethod("org/haxe/extension/facebookAds/FacebookAds", "hideBanner", "()V");
			initialized = true;
			__init(testingAds,null,bannerID,interstitialID);
		} catch(e:Dynamic) {
			trace("Error: "+e);
		}
	}

	////////////////////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////


	private static var lastTimeInterstitial:Int = -60*1000;
	private static var displayCallsCounter:Int = 0;
	
	public static function showInterstitial(minInterval:Int=60, minCallsBeforeDisplay:Int=0):Bool {
		displayCallsCounter++;
		if( (Lib.getTimer()-lastTimeInterstitial)<(minInterval*1000) ) return false;
		if( minCallsBeforeDisplay > displayCallsCounter ) return false;
		try {
			if(!__showInterstitial()) return false;
			displayCallsCounter = 0;
			lastTimeInterstitial = Lib.getTimer();
			return true;
		} catch(e:Dynamic) {
			trace("ShowInterstitial Exception: "+e);
		}
		return false;
	}

	////////////////////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////

}