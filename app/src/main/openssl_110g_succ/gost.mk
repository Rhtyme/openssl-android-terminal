LOCAL_ADDITIONAL_DEPENDENCIES += $(LOCAL_PATH)/gost.mk

GOST_COMMON_CFLAGS := \
  -DANDROID -DOPENSSL_NO_ASM -DOPENSSL_THREADS -D_REENTRANT \
  -DDSO_DLFCN -DHAVE_DLFCN_H -DOPENSSL_NO_CAST -DOPENSSL_NO_CAMELLIA \
  -DOPENSSL_NO_IDEA -DOPENSSL_NO_MDC2 -DOPENSSL_NO_SEED -DOPENSSL_NO_WHIRLPOOL \
  -DOPENSSL_NO_RSAX -DOPENSSL_NO_RDRAND -DOPENSSL_NO_HW -DHAVE_OPENSSL_ENGINE_H \
  -DHAVE_ENGINE_LOAD_BUILTIN_ENGINES -DNO_WINDOWS_BRAINDEATH -DOPENSSL_NO_AFALGENG

GOST_COMMON_CFLAGS += -Wno-typedef-redefinition -Wno-sign-compare\
  -Wno-incompatible-pointer-types-discards-qualifiers

GOST_SRC := \
   engines/ccgost/gost12sum.c \
   engines/ccgost/gost89.c \
   engines/ccgost/gost_ameth.c \
   engines/ccgost/gost_asn1.c \
   engines/ccgost/gost_crypt.c \
   engines/ccgost/gost_ctl.c \
   engines/ccgost/gost_ec_keyx.c \
   engines/ccgost/gost_ec_sign.c \
   engines/ccgost/gost_eng.c \
   engines/ccgost/gost_grasshopper_cipher.c \
   engines/ccgost/gost_grasshopper_core.c \
   engines/ccgost/gost_grasshopper_defines.c \
   engines/ccgost/gost_grasshopper_galois_precompiled.c \
   engines/ccgost/gost_grasshopper_mac.c \
   engines/ccgost/gost_grasshopper_precompiled.c \
   engines/ccgost/gosthash.c \
   engines/ccgost/gost_keywrap.c \
   engines/ccgost/gost_md.c \
   engines/ccgost/gost_params.c \
   engines/ccgost/gost_pmeth.c \
   engines/ccgost/gosthash2012.c \
   engines/ccgost/gost_md2012.c \
   engines/ccgost/e_gost_err.c

GOST_LOCAL_SRC_FILES := $(GOST_CSOURCES)
#$(addprefix crypto/,$(GOST_CSOURCES))
#\
#						  $(addprefix engines/,$(GOST_SRC))

GOST_LOCAL_C_INCLUDES += $(LOCAL_PATH) \
                    $(LOCAL_PATH)/. \
                    $(LOCAL_PATH)/include \
                    $(LOCAL_PATH)/include/openssl \
                    $(LOCAL_PATH)/crypto \

LOCAL_C_INCLUDES := $(GOST_LOCAL_C_INCLUDES)
LOCAL_SRC_FILES := $(GOST_CSOURCES)