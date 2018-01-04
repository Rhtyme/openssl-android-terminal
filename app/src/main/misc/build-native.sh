#!/bin/bash

# Exit on errors
set -e

export NDK_ROOT="/mnt/325E8FF25E8FACE3/install/LSofts/android-sdk-linux/ndk-bundle"
export NDK_PATH="/mnt/325E8FF25E8FACE3/install/LSofts/android-sdk-linux/ndk-bundle"
export PATH=$PATH:"/mnt/325E8FF25E8FACE3/install/LSofts/android-sdk-linux/ndk-bundle"

ndk-build NDK_LOG=1 $@
#NDK_DEBUG=1

if [ $? = 0 ]; then
	rm -rf ovpnlibs/

	cd libs
	mkdir -p ../ovpnlibs/assets
	for i in *
	do
		cp -v $i/gapps_exec ../ovpnlibs/assets/gapps_exec.$i
	done
    cp ../openssl/apps/openssl.cnf ../ovpnlibs/assets/openssl.cnf 

  	for arch in *
  	do
  	    builddir=../ovpnlibs/jniLibs/$arch
  	    mkdir -p $builddir
  		cp -v $arch/*.so  $builddir
  	done
else
    exit $?
fi
