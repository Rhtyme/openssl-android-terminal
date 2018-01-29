#LOCAL_ADDITIONAL_DEPENDENCIES += $(LOCAL_PATH)/apps.mk
APPS_COMMON_CFLAGS := \
  -DANDROID -DOPENSSL_NO_ASM -DOPENSSL_THREADS -D_REENTRANT \
  -DDSO_DLFCN -DHAVE_DLFCN_H -DOPENSSL_NO_CAST -DOPENSSL_NO_CAMELLIA \
  -DOPENSSL_NO_IDEA -DOPENSSL_NO_MDC2 -DOPENSSL_NO_SEED -DOPENSSL_NO_WHIRLPOOL \
  -DOPENSSL_NO_RSAX -DOPENSSL_NO_RDRAND -DOPENSSL_NO_HW -DHAVE_OPENSSL_ENGINE_H \
  -DHAVE_ENGINE_LOAD_BUILTIN_ENGINES -DMONOLITH -DOPENSSL_C -DOPENSSL_NO_DH

APPS_COMMON_CFLAGS += -Wno-typedef-redefinition -Wno-sign-compare\
  -Wno-incompatible-pointer-types-discards-qualifiers

APPS_CSOURCES := \
  apps/asn1pars.c \
  apps/apps.c \
  apps/ca.c \
  apps/ciphers.c \
  apps/cms.c \
  apps/crl.c \
  apps/crl2p7.c \
  apps/dgst.c \
  apps/dhparam.c \
  apps/dsa.c \
  apps/dsaparam.c \
  apps/ec.c \
  apps/ecparam.c \
  apps/enc.c \
  apps/engine.c \
  apps/errstr.c \
  apps/gendsa.c \
  apps/genpkey.c \
  apps/genrsa.c \
  apps/nseq.c \
  apps/ocsp.c \
  apps/openssl.c \
  apps/passwd.c \
  apps/pkcs12.c \
  apps/pkcs7.c \
  apps/pkcs8.c \
  apps/pkey.c \
  apps/pkeyparam.c \
  apps/pkeyutl.c \
  apps/prime.c \
  apps/rand.c \
  apps/req.c \
  apps/rsa.c \
  apps/rsautl.c \
  apps/s_cb.c \
  apps/s_client.c \
  apps/s_server.c \
  apps/s_socket.c \
  apps/s_time.c \
  apps/sess_id.c \
  apps/smime.c \
  apps/speed.c \
  apps/srp.c \
  apps/verify.c \
  apps/version.c \
  apps/x509.c \
  apps/app_rand.c \
  apps/opt.c
#  apps/ts.c
#  apps/spkac.c \
#  apps/dh.c \
#  apps/gendh.c \


#APPS_CSOURCES := \
#  apps/apps.c \
#  apps/version.c

#ts.c md4.c s_client.c s_server.c  speed.c
#    openssl.c apps.c engine.c s_client.c dgst.c enc.c s_client.c
#apps.c engine.c s_client.c

#APPS_LOCAL_SRC_FILES := $(APPS_CSOURCES)

#$(addprefix apps/,$(APPS_CSOURCES))

APPS_LOCAL_C_INCLUDES := \
                    $(LOCAL_PATH) \
                    $(LOCAL_PATH)/include \
                    $(LOCAL_PATH)/ssl \
                    $(LOCAL_PATH)/apps \
                    $(LOCAL_PATH)/crypto

#$(LOCAL_PATH)/crypto/asn1 \
#$(LOCAL_PATH)/crypto/evp \
#$(LOCAL_PATH)/crypto/modes \