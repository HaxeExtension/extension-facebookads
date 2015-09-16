@ECHO OFF
SET EXTNAME="extension-facebookads"

REM Build extension
zip -r %EXTNAME%.zip extension haxelib.json include.xml dependencies
