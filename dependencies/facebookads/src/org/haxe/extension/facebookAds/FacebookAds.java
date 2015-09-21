package org.haxe.extension.facebookAds;

import android.util.Log;
import android.view.ViewGroup;
import org.haxe.extension.Extension;
import org.haxe.lime.HaxeObject;
import android.widget.FrameLayout;
import android.view.View;
import android.view.Gravity;
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
	protected static boolean bannerVisible = false;

	public static void init(boolean testingAds, HaxeObject callback, String bannerID, String interstitialID, final boolean alignTop) {
		Log.d(TAG, "init: begins");
		_callback = callback;
		if(testingAds) useTestingAds();
		FacebookAds.interstitialID = interstitialID;
		FacebookAds.bannerID = bannerID;
		Extension.mainActivity.runOnUiThread(new Runnable() {
			public void run() {
				// banner init
				adView = new AdView(Extension.mainActivity.getApplicationContext(), FacebookAds.bannerID, AdSize.BANNER_HEIGHT_50);
				FrameLayout.LayoutParams params = new FrameLayout.LayoutParams(
					FrameLayout.LayoutParams.MATCH_PARENT,
					FrameLayout.LayoutParams.WRAP_CONTENT);
				
				if(alignTop) {
					params.gravity = Gravity.CENTER_HORIZONTAL | Gravity.TOP;
				} else {
					params.gravity = Gravity.CENTER_HORIZONTAL | Gravity.BOTTOM;
				}

				Extension.mainActivity.addContentView(adView,params);

				adView.setAdListener(new AdListener() {
					@Override
					public void onError(Ad ad, AdError error) {
						// Ad failed to load. 
						// Add code to hide the ad's view
						Log.d(TAG, "onError (banner)");
					}

					@Override
					public void onAdLoaded(Ad ad) {
						// Ad was loaded
						// Add code to show the ad's view
						Log.d(TAG, "onAdLoaded (banner)");
					}

					@Override
					public void onAdClicked(Ad ad) {
						// Use this function to detect when an ad was clicked.
						Log.d(TAG, "onAdClicked (banner)");
					}
				});

				//adView.loadAd();
				adView.setVisibility(View.GONE);

				// interstitial init
				cacheInterstitial();
				Log.d(TAG, "init: complete");
			}
		});
	}
	
	public static void showBanner() {
		if(bannerVisible) return;
		Extension.mainActivity.runOnUiThread(new Runnable() {
			public void run() {
				adView.loadAd();
				adView.setVisibility(View.VISIBLE);
				bannerVisible = true;
			}
		});
	}
	
	public static void hideBanner() {
		if(!bannerVisible) return;
		Extension.mainActivity.runOnUiThread(new Runnable() {
			public void run() {
				adView.disableAutoRefresh();
				adView.setVisibility(View.GONE);
				bannerVisible = false;
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