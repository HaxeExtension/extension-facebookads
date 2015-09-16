package org.haxe.extension.facebookAds;

import android.util.Log;
import android.view.ViewGroup;
import android.widget.RelativeLayout;
import org.haxe.extension.Extension;
import org.haxe.lime.HaxeObject;

import com.amazon.device.ads.*;

public class FacebookAds extends Extension
{

	protected static HaxeObject _callback = null;
	static final String TAG = "FacebookAds";
	
	public static void init(String appID, HaxeObject callback)
	{
		_callback = callback;
		Extension.mainActivity.runOnUiThread(new Runnable()
		{
			public void run()
			{

			}
		});
		
		Log.d(TAG, "init: "+callback);
	}
	
	public static void showAd()
	{
		Extension.mainActivity.runOnUiThread(new Runnable()
		{
			public void run()
			{
				
			}
		});
	}
	
	public static void hideAd() {
		Extension.mainActivity.runOnUiThread(new Runnable()
		{
			public void run()
			{
				
			}
		});
	}
	
	public static void cacheInterstitial() {
		Extension.mainActivity.runOnUiThread(new Runnable()
		{
			public void run()
			{
				
			}
		});
	}

	public static void showInterstitial()
	{
		Extension.mainActivity.runOnUiThread(new Runnable()
		{
			public void run()
			{
				
			}
		});
	}

	public static void enableTesting(boolean enable) {
	
	}

	@Override
	public void onDestroy()	{

	}

}