package extension.facebookads;
#if android
import openfl.utils.JNI;
#end
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

	public static function init(bannerID:String,interstitialID:String,alignTop:Bool) {
		if(initialized) return;
		initialized = true;
		#if android
			try {
				var __init:Bool->FacebookAds->String->String->Bool->Void;
				__init = JNI.createStaticMethod("org/haxe/extension/facebookAds/FacebookAds","init","(ZLorg/haxe/lime/HaxeObject;Ljava/lang/String;Ljava/lang/String;Z)V");
				__showInterstitial = JNI.createStaticMethod("org/haxe/extension/facebookAds/FacebookAds", "showInterstitial", "()Z");
				showBanner = JNI.createStaticMethod("org/haxe/extension/facebookAds/FacebookAds", "showBanner", "()V");
				hideBanner = JNI.createStaticMethod("org/haxe/extension/facebookAds/FacebookAds", "hideBanner", "()V");
				__init(testingAds,null,bannerID,interstitialID,alignTop);
			} catch(e:Dynamic) {
				trace("Error: "+e);
			}
		#elseif ios
			try{
				// CPP METHOD LINKING
				var __init:String->String->Bool->Bool->Void;
				__init = cpp.Lib.load("facebookAdsEx","facebookadsex_init",4);
				showBanner = cpp.Lib.load("facebookAdsEx","facebookadsex_banner_show",0);
				hideBanner = cpp.Lib.load("facebookAdsEx","facebookadsex_banner_hide",0);
				__showInterstitial = cpp.Lib.load("facebookAdsEx","facebookadsex_interstitial_show",0);
				//__refresh = cpp.Lib.load("facebookAdsEx","facebookadsex_banner_refresh",0);
				__init(bannerID,interstitialID,alignTop,testingAds);
			}catch(e:Dynamic){
				trace("iOS INIT Exception: "+e);
			}
		#end
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