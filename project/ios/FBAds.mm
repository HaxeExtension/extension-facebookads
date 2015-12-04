#include <FacebookAdsEx.h>
#import <UIKit/UIKit.h>
#import <FBAudienceNetwork/FBAudienceNetwork.h>

@interface FBInterstitialView : NSObject <FBInterstitialAdDelegate>
{
	FBInterstitialAd *interstitialAd;
	NSString *PLACEMENT_ID;
	FBInterstitialAd *loadedAd;
}
@end

@implementation FBInterstitialView


- (id)initWithID:(NSString*)ID {
	self = [super init];
	loadedAd = nil;
	if(!self) return nil;
	PLACEMENT_ID = ID;
	return self;
}

- (bool) showInterstitial
{
	if(loadedAd==nil) return false;
	UIViewController *root = [[[UIApplication sharedApplication] keyWindow] rootViewController];
	// You can now display the full screen ad using this code:
	[loadedAd showAdFromRootViewController:root];
	[self loadInterstital];
	return true;
}

- (void) loadInterstital
{
	loadedAd = nil;
	interstitialAd = [[FBInterstitialAd alloc] initWithPlacementID:PLACEMENT_ID];
	interstitialAd.delegate = self;
	[interstitialAd loadAd];
}

- (void)interstitialAdDidLoad:(FBInterstitialAd *)ad
{
	loadedAd = ad;
	NSLog(@"Ad is loaded and ready to be displayed");
}

- (void)interstitialAd:(FBInterstitialAd *)ad didFailWithError:(NSError *)error
{
	loadedAd = nil;
	NSLog(@"Ad failed to load");
}

- (void)interstitialAdDidClick:(FBInterstitialAd *)ad
{
	NSLog(@"The user clicked on the ad and will be taken to its destination");
	// Use this function as indication for a user's click on the ad.
}

- (void)interstitialAdWillClose:(FBInterstitialAd *)ad
{
	NSLog(@"The user clicked on the close button, the ad is just about to close");
	// Consider to add code here to resume your app's flow
}

- (void)interstitialAdDidClose:(FBInterstitialAd *)ad
{
	NSLog(@"Interstitial had been closed");
	// Consider to add code here to resume your app's flow
}

@end


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
