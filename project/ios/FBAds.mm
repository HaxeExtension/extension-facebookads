#include <FacebookAdsEx.h>
#include "FBInterstitialView.mm"

namespace facebookadsex {
	
	static FBInterstitialView *interstitial;
	static FBAdView *bannerView;
	
	void init(const char *__BannerID, const char *__InterstitialID, bool alignTop, bool testingAds){
		NSString *bannerID = [NSString stringWithUTF8String:__BannerID];
		NSString *interstitialID = [NSString stringWithUTF8String:__InterstitialID];
		UIViewController *root = [[[UIApplication sharedApplication] keyWindow] rootViewController];

		if(testingAds){
			//[FBAdSettings addTestDevice:@"HASHED ID"];
		}

		bannerView = [[FBAdView alloc] initWithPlacementID:bannerID
									adSize:kFBAdSizeHeight50Banner
									rootViewController:root];

		[bannerView loadAd];
		[root.view addSubview:bannerView];

		interstitial = [[FBInterstitialView alloc] initWithID:interstitialID];
		[interstitial loadInterstital];

		// THOSE THREE LINES ARE FOR SETTING THE BANNER BOTTOM ALIGNED
		if(!alignTop){
			CGRect frame = bannerView.frame;
			frame.origin.y = root.view.bounds.size.height - frame.size.height;
			bannerView.frame=frame;
		}

		hideBanner();
	}
	
	void showBanner(){
		bannerView.hidden=false;
	}
	
	void hideBanner(){
		bannerView.hidden=true;
	}
	
  	void refreshBanner(){
		// [bannerView loadRequest:[GADRequest request]];
	}

	bool showInterstitial(){
		if(interstitial == nil ) return false;
		return [interstitial showInterstitial];
	}

}
