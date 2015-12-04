#ifndef STATIC_LINK
#define IMPLEMENT_API
#endif

#if defined(HX_WINDOWS) || defined(HX_MACOS) || defined(HX_LINUX)
#define NEKO_COMPATIBLE
#endif


#include <hx/CFFI.h>
#include "FacebookAdsEx.h"

using namespace facebookadsex;


static value facebookadsex_init(value banner_id,value interstitial_id, value align_top, value testing_ads){
	init(val_string(banner_id),val_string(interstitial_id), val_bool(align_top), val_bool(testing_ads));
	return alloc_null();
}
DEFINE_PRIM(facebookadsex_init,4);

static value facebookadsex_banner_show(){
	showBanner();
	return alloc_null();
}
DEFINE_PRIM(facebookadsex_banner_show,0);

static value facebookadsex_banner_hide(){
	hideBanner();
	return alloc_null();
}
DEFINE_PRIM(facebookadsex_banner_hide,0);

static value facebookadsex_banner_refresh(){
	refreshBanner();
	return alloc_null();
}
DEFINE_PRIM(facebookadsex_banner_refresh,0);


extern "C" void facebookadsex_main () {	
	val_int(0); // Fix Neko init
	
}
DEFINE_ENTRY_POINT (facebookadsex_main);


static value facebookadsex_interstitial_show(){
	return alloc_bool(showInterstitial());
}
DEFINE_PRIM(facebookadsex_interstitial_show,0);



extern "C" int facebookadsex_register_prims () { return 0; }
