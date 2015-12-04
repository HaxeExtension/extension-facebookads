#include <FacebookAdsEx.h>
#include "FBInterstitialView.mm"

namespace facebookadsex {
	
	static FBInterstitialView *interstitial;
	
	void init(const char *__BannerID, const char *__InterstitialID, bool alignTop, bool testingAds){
		NSString *bannerID = [NSString stringWithUTF8String:__BannerID];
		NSString *interstitialID = [NSString stringWithUTF8String:__InterstitialID];

		if(testingAds){
			//[FBAdSettings addTestDevice:@"HASHED ID"];
		}

		interstitial = [[FBInterstitialView alloc] initWithID:interstitialID];
		[interstitial loadInterstital];
	}
	
	void showBanner(){
//		bannerView.hidden=false;
	}
	
	void hideBanner(){
//		bannerView.hidden=true;
	}
	
  	void refreshBanner(){
//		[bannerView loadRequest:[GADRequest request]];
	}

	bool showInterstitial(){
		if(interstitial == nil ) return false;
		return [interstitial showInterstitial];
	}

}
