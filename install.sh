#!/bin/bash
dir=`dirname "$0"`
cd "$dir"
PKG_NAME="extension-facebookads"

haxelib remove "$PKG_NAME"
haxelib local "${PKG_NAME}.zip"
