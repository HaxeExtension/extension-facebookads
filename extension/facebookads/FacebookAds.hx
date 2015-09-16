package extension.facebookads;
import openfl.utils.JNI;

class FacebookAds {
	private static var initialized:Bool = false;

	private static var __showInterstitial():Void = function(){}

	public static function init(){
		if(initialized) return;
		try{
			var __init:FacebookAds->Void;

			__init = JNI.createStaticMethod("org/haxe/extension/facebookAds/FacebookAds","init","(ZLorg/haxe/lime/HaxeObject;)V");
			__showInterstitial = JNI.createStaticMethod("org/haxe/extension/facebookAds/FacebookAds", "showInterstitial", "()V");

			initialized = true;
			__init(null);

		}catch(e:js.html.Exception){
			trace("Error: "+e.message);
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