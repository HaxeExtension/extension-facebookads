package org.haxe.extension.facebookAds;

import android.util.Log;
import android.view.ViewGroup;
import android.widget.RelativeLayout;
import org.haxe.extension.Extension;
import org.haxe.lime.HaxeObject;

import com.facebook.ads.*;

public class FacebookAds extends Extension implements InterstitialAdListener
{

	///////////////////////////////////////////////////////////////////////////
	// INSTANCE STUFF
	///////////////////////////////////////////////////////////////////////////

	protected static FacebookAds instance = null;
	
	protected static FacebookAds getInstance(){
		if(instance == null) instance = new FacebookAds();
		return instance;
	}

	protected FacebookAds () { }

	///////////////////////////////////////////////////////////////////////////
	// STATIC STUFF
	///////////////////////////////////////////////////////////////////////////

	protected static HaxeObject _callback = null;
	protected static InterstitialAd interstitialAd;
	protected static final String TAG = "FacebookAds";
	protected static AdView adView;
	protected static String interstitialID = null;

	public static void init(boolean testingAds, HaxeObject callback, String interstitialID) {
		Log.d(TAG, "init: begins");
		_callback = callback;
		if(testingAds) useTestingAds();
		FacebookAds.interstitialID = interstitialID;
		Extension.mainActivity.runOnUiThread(new Runnable() {
			public void run() {
				AdSettings.addTestDevice("4c9b83f0aceabecbde1c1e1f5117d065");
				cacheInterstitial();
				Log.d(TAG, "init: complete");
			}
		});
	}
	
	public static void showAd() {
		Extension.mainActivity.runOnUiThread(new Runnable() {
			public void run() {
				
			}
		});
	}
	
	public static void hideAd() {
		Extension.mainActivity.runOnUiThread(new Runnable() {
			public void run() {

			}
		});
	}
	
	private static void cacheInterstitial() {
		Log.d(TAG, "cacheInterstitial: begin");
		interstitialAd = new InterstitialAd(Extension.mainActivity, FacebookAds.interstitialID);
		interstitialAd.setAdListener(getInstance());
		interstitialAd.loadAd();				
		Log.d(TAG, "cacheInterstitial: end");
	}

	public static void showInterstitial() {
		Extension.mainActivity.runOnUiThread(new Runnable() {
			public void run() {
				interstitialAd.show();
				cacheInterstitial();
			}
		});
	}

	private static void useTestingAds() {
		String id = Extension.mainActivity.getApplicationContext().getSharedPreferences("FBAdPrefs", 0).getString("deviceIdHash", null);
		Log.d(TAG,"Enabling Testing Ads for hashID: "+id);
		AdSettings.addTestDevice(id);
	}

	///////////////////////////////////////////////////////////////////////////
	// FACBEOOK EVENTS
	///////////////////////////////////////////////////////////////////////////

	@Override
	public void onError(Ad ad, AdError error) {
	    // Ad failed to load
		Log.e(TAG, "onError: (code "+error.getErrorCode()+") "+error.getErrorMessage());
	}

	@Override
	public void onAdLoaded(Ad ad) {
		// Ad is loaded and ready to be displayed  
		// You can now display the full screen ad using this code:      
		// ad.show();
		Log.d(TAG, "onAdLoaded: call");
	}

	@Override
	public void onInterstitialDisplayed(Ad ad) {
		// Where relevant, use this function to pause your app's flow
		Log.d(TAG, "onInterstitialDisplayed: call");
	}

	@Override
	public void onInterstitialDismissed(Ad ad) {
		// Use this function to resume your app's flow
		Log.d(TAG, "onInterstitialDismissed: call");
	}

	@Override
	public void onAdClicked(Ad ad) {
		// Use this function as indication for a user's click on the ad.
		Log.d(TAG, "onAdClicked: call");
	}

	///////////////////////////////////////////////////////////////////////////
	// EXTENSION EVENTS
	///////////////////////////////////////////////////////////////////////////

	@Override
	public void onDestroy()	{
		if (interstitialAd != null) {
			interstitialAd.destroy();
		}
	}

}