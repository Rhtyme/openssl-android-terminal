M_PATH = $(abspath $(call my-dir))

#LOCAL_PATH := $(call my-dir)
LOCAL_PATH := $(M_PATH)


#$(warning The local path)
#$(info The local path)

#$(warning $(LOCAL_PATH))

#SSL
include $(LOCAL_PATH)/ssl.mk

#Crypto
include $(LOCAL_PATH)/crypto.mk

#Apps
include $(LOCAL_PATH)/apps.mk

# ********************Crypto module***********************
###********************STATIC***********************
include $(CLEAR_VARS)
LOCAL_SRC_FILES := $(CRYPTO_LOCAL_SRC_FILES)
LOCAL_C_INCLUDES := $(CRYPTO_LOCAL_C_INCLUDES)
#$(warning $(CRYPTO_LOCAL_SRC_FILES))

#$(warning $(CRYPTO_LOCAL_C_INCLUDES))

LOCAL_CPPFLAGS += -std=gnu++0x
LOCAL_SDK_VERSION := 9
include $(LOCAL_PATH)/optimizations.mk
LOCAL_CFLAGS += $(CRYPTO_COMMON_CFLAGS)
# The static library should be used in only unbundled apps
# and we don't have clang in unbundled build yet.
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE := libgcrypto_static
include $(LOCAL_PATH)/android-config.mk
include $(BUILD_STATIC_LIBRARY)

###******************SHARED***********************
# target shared library
include $(CLEAR_VARS)

# If we're building an unbundled build, don't try to use clang since it's not
# in the NDK yet. This can be removed when a clang version that is fast enough
# in the NDK.
LOCAL_SRC_FILES := $(CRYPTO_LOCAL_SRC_FILES)
LOCAL_C_INCLUDES := $(CRYPTO_LOCAL_C_INCLUDES)
LOCAL_CPPFLAGS += -std=gnu++0x
include $(LOCAL_PATH)/optimizations.mk
LOCAL_CFLAGS += $(CRYPTO_COMMON_CFLAGS)

LOCAL_SDK_VERSION := 9

LOCAL_MODULE_TAGS := optional
LOCAL_MODULE := libgcrypto
include $(LOCAL_PATH)/android-config.mk
include $(BUILD_SHARED_LIBRARY)

# ********************SSL module***********************

# ********************STATIC***********************

include $(CLEAR_VARS)
LOCAL_MODULE := libgssl_static
LOCAL_SRC_FILES := $(SSL_LOCAL_SRC_FILES)
LOCAL_C_INCLUDES := $(SSL_LOCAL_C_INCLUDES) $(CRYPTO_LOCAL_C_INCLUDES)
LOCAL_CPPFLAGS += -std=gnu++0x
include $(LOCAL_PATH)/optimizations.mk
LOCAL_CFLAGS += $(SSL_COMMON_CFLAGS)
LOCAL_SDK_VERSION := 9
LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/include
LOCAL_STATIC_LIBRARIES := libgcrypto_static
include $(LOCAL_PATH)/android-config.mk
include $(BUILD_STATIC_LIBRARY)


# ********************SHARED***********************

include $(CLEAR_VARS)

# If we're building an unbundled build, don't try to use clang since it's not
# in the NDK yet. This can be removed when a clang version that is fast enough
# in the NDK.

LOCAL_SHARED_LIBRARIES += libgcrypto
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE := libgssl

LOCAL_SDK_VERSION := 9
LOCAL_SRC_FILES := $(SSL_LOCAL_SRC_FILES)
LOCAL_C_INCLUDES := $(SSL_LOCAL_C_INCLUDES) $(CRYPTO_LOCAL_C_INCLUDES)
LOCAL_CPPFLAGS += -std=gnu++0x
include $(LOCAL_PATH)/optimizations.mk
LOCAL_CFLAGS += $(SSL_COMMON_CFLAGS)
LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/include
include $(LOCAL_PATH)/android-config.mk
include $(BUILD_SHARED_LIBRARY)

# ********************Apps module***********************
###********************STATIC***********************
include $(CLEAR_VARS)
LOCAL_SRC_FILES := $(APPS_LOCAL_SRC_FILES)
LOCAL_C_INCLUDES := $(APPS_LOCAL_C_INCLUDES)

LOCAL_STATIC_LIBRARIES := libgcrypto_static libgssl

LOCAL_CPPFLAGS += -std=gnu++0x
LOCAL_SDK_VERSION := 9
include $(LOCAL_PATH)/optimizations.mk
LOCAL_CFLAGS += $(APPS_COMMON_CFLAGS)
# The static library should be used in only unbundled apps
# and we don't have clang in unbundled build yet.
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE := libgapps_static
include $(LOCAL_PATH)/android-config.mk
include $(BUILD_STATIC_LIBRARY)

###******************SHARED***********************
# target shared library
include $(CLEAR_VARS)

# If we're building an unbundled build, don't try to use clang since it's not
# in the NDK yet. This can be removed when a clang version that is fast enough
# in the NDK.
LOCAL_SRC_FILES := $(APPS_LOCAL_SRC_FILES)
LOCAL_C_INCLUDES := $(APPS_LOCAL_C_INCLUDES)
LOCAL_CPPFLAGS += -std=gnu++0x
LOCAL_SHARED_LIBRARIES := libgcrypto libgssl
include $(LOCAL_PATH)/optimizations.mk
LOCAL_CFLAGS += $(APPS_COMMON_CFLAGS)

LOCAL_SDK_VERSION := 9

LOCAL_MODULE_TAGS := optional
LOCAL_MODULE := libgapps
include $(LOCAL_PATH)/android-config.mk
include $(BUILD_SHARED_LIBRARY)

# *******************************************