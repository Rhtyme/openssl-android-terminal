# Path of the sources
JNI_DIR := $(call my-dir)

include openssl/Android.mk

LOCAL_PATH := $(JNI_DIR)

include $(CLEAR_VARS)

LOCAL_LDLIBS += -lz  -lc
LOCAL_STATIC_LIBRARIES := libgssl_static libgcrypto_static libgapps
#LOCAL_STATIC_LIBRARIES := libssl_static libcrypto_static openssl
#LOCAL_STATIC_LIBRARIES := libssl libcrypto openssl
#openssl
#libgapps_static
LOCAL_CFLAGS += -fPIE -pie
LOCAL_CPPFLAGS += -fPIE
LOCAL_ALLOW_UNDEFINED_SYMBOLS := true
LOCAL_LDFLAGS += -fPIE -pie
LOCAL_SRC_FILES := minivpn.c dummy.cpp
LOCAL_MODULE = gapps_exec
include $(BUILD_EXECUTABLE)

# The only real JNI libraries
include $(CLEAR_VARS)
LOCAL_LDLIBS := -llog  -lz
LOCAL_CFLAGS =  -DTARGET_ARCH_ABI=\"${TARGET_ARCH_ABI}\"
LOCAL_SRC_FILES:= jniglue.c  scan_ifs.c
LOCAL_MODULE = opvpnutil
include $(BUILD_SHARED_LIBRARY)
