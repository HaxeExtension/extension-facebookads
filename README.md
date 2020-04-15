Introduction
============
FacebookAds Extension (Facebook Audience Network (ads) extension.)

More info on Facebook Audience Network: https://developers.facebook.com/docs/audience-network


### How to Install

To install this library, you can simply get the library from haxelib like this:
```bash
haxelib install extension-facebookads
```

Once this is done, you just need to add this to your project.xml
```xml
<haxelib name="extension-facebookads" />
```

### Troubleshooting (checklist)
If you're having issues, here are some points you should check if you're not getting ads:

1. Is your game already enabled on facebook audience network? _(note that facebook requires the game to be manually authorized on their network before you can get ADS)_.
2. Did you set up audience network to display low RPM ads? _(this affects the inventory, so you may want to ensure inventory while testing)_.
3. Are you sure that the lack of ads is not caused due to lack of inventory? _(you should check your device logcat to see if there's any message related to ads inventory)_.
4. Do you see any alert on your FB App console? _(sometimes Facebook alerts you on the Dev console, go there to see it)_.
5. Did you wait some hours after the first ad request to allow facebook to get inventory for you app?
6. Have you tried enabling the test ad mode?

If you're having issues compiling you game after installing this extension, you should:

1. check the proper installation of extension-android-support-v4

### Disclaimer

Facebook is a registered trademark of Facebook Inc.
http://unibrander.com/united-states/221811US/facebook.html

### License

The MIT License (MIT) - [LICENSE.md](LICENSE.md)

Copyright &copy; 2015 SempaiGames (http://www.sempaigames.com)

Author: Federico Bricker
