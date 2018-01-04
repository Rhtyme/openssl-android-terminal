APP_ABI := armeabi-v7a arm64-v8a x86 x86_64
#lenova:armeabi-v7a
#samsung j5 prime : armeabi-v7a

#x86 x86_64
#arm64-v8a armeabi
APP_PLATFORM := android-14
#APP_PLATFORM := android-21

#APP_STL:=stlport_static
APP_STL:=c++_static


#APP_OPTIM := release

#NDK_TOOLCHAIN_VERSION=4.9
APP_CPPFLAGS += -std=c++1y
APP_CFLAGS += -funwind-tables
APP_OPTIM := debug


