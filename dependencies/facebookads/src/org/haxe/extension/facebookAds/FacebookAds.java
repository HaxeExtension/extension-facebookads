package org.haxe.extension.facebookAds;

import android.util.Log;
import android.view.ViewGroup;
import android.widget.RelativeLayout;
import org.haxe.extension.Extension;
import org.haxe.lime.HaxeObject;
import android.widget.RelativeLayout.LayoutParams;
import android.view.View;
import com.facebook.ads.*;

public class FacebookAds extends Extension implements InterstitialAdListener
{

	///////////////////////////////////////////////////////////////////////////
	// INSTANCE STUFF
	///////////////////////////////////////////////////////////////////////////

	protected static FacebookAds instance = null;
	
	protected static FacebookAds getInstance() {
		if(instance == null) instance = new FacebookAds();
		return instance;
	}

	protected FacebookAds () { }

	///////////////////////////////////////////////////////////////////////////
	// STATIC STUFF
	///////////////////////////////////////////////////////////////////////////

	protected static HaxeObject _callback = null;
	protected static InterstitialAd interstitialAd;
	protected static AdView adView;
	protected static String interstitialID = null;
	protected static String bannerID = null;
	protected static boolean interstitialLoaded = false;
	protected static final String TAG = "FacebookAds";

	public static void init(boolean testingAds, HaxeObject callback, String bannerID, String interstitialID) {
		Log.d(TAG, "init: begins");
		_callback = callback;
		if(testingAds) useTestingAds();
		FacebookAds.interstitialID = interstitialID;
		FacebookAds.bannerID = bannerID;
		Extension.mainActivity.runOnUiThread(new Runnable() {
			public void run() {
				// banner init
				adView = new AdView(Extension.mainActivity.getApplicationContext(), FacebookAds.bannerID, AdSize.BANNER_HEIGHT_50);
				LayoutParams params = new LayoutParams(
					LayoutParams.MATCH_PARENT,
					LayoutParams.MATCH_PARENT);					
				Extension.mainActivity.addContentView(adView,params);
				adView.loadAd();
				adView.setVisibility(View.GONE);

				// interstitial init
				cacheInterstitial();
				Log.d(TAG, "init: complete");
			}
		});
	}
	
	public static void showBanner() {
		Extension.mainActivity.runOnUiThread(new Runnable() {
			public void run() {
				adView.setVisibility(View.VISIBLE);
			}
		});
	}
	
	public static void hideBanner() {
		Extension.mainActivity.runOnUiThread(new Runnable() {
			public void run() {
				adView.setVisibility(View.GONE);
			}
		});
	}
	
	private static void cacheInterstitial() {
		Log.d(TAG, "cacheInterstitial: begin");
		interstitialLoaded = false;
		interstitialAd = new InterstitialAd(Extension.mainActivity, FacebookAds.interstitialID);
		interstitialAd.setAdListener(getInstance());
		interstitialAd.loadAd();
		Log.d(TAG, "cacheInterstitial: end");
	}

	public static boolean showInterstitial() {
		if(!interstitialLoaded) return false;
		Extension.mainActivity.runOnUiThread(new Runnable() {
			public void run() {
				if(interstitialLoaded){
					interstitialAd.show();
					cacheInterstitial();
				}
			}
		});
		return true;
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
		interstitialLoaded = true;
		Log.d(TAG, "onAdLoaded");
	}

	@Override
	public void onInterstitialDisplayed(Ad ad) {
		// Where relevant, use this function to pause your app's flow
		Log.d(TAG, "onInterstitialDisplayed");
	}

	@Override
	public void onInterstitialDismissed(Ad ad) {
		// Use this function to resume your app's flow
		Log.d(TAG, "onInterstitialDismissed");
	}

	@Override
	public void onAdClicked(Ad ad) {
		// Use this function as indication for a user's click on the ad.
		Log.d(TAG, "onAdClicked");
	}

	///////////////////////////////////////////////////////////////////////////
	// EXTENSION EVENTS
	///////////////////////////////////////////////////////////////////////////

	@Override
	public void onDestroy()	{
		if (interstitialAd != null) interstitialAd.destroy();
		if (adView != null) adView.destroy();
		interstitialAd = null;
		adView = null;
	}

}