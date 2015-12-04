#ifndef FACEBOOKADSEX_H
#define FACEBOOKADSEX_H


namespace facebookadsex {
	
	
	void init(const char *BannerID, const char *InterstitialID, bool alignTop, bool testingAds);
	void showBanner();
	void hideBanner();
	void refreshBanner();
	bool showInterstitial();
	
}


#endif