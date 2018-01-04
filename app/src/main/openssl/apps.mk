APPS_COMMON_CFLAGS := \
  -DANDROID -DOPENSSL_NO_ASM -DOPENSSL_THREADS -D_REENTRANT \
  -DDSO_DLFCN -DHAVE_DLFCN_H -DOPENSSL_NO_CAST -DOPENSSL_NO_CAMELLIA \
  -DOPENSSL_NO_IDEA -DOPENSSL_NO_MDC2 -DOPENSSL_NO_SEED -DOPENSSL_NO_WHIRLPOOL \
  -DOPENSSL_NO_RSAX -DOPENSSL_NO_RDRAND -DOPENSSL_NO_HW -DHAVE_OPENSSL_ENGINE_H \
  -DHAVE_ENGINE_LOAD_BUILTIN_ENGINES -DMONOLITH -DOPENSSL_C

APPS_COMMON_CFLAGS += -Wno-typedef-redefinition -Wno-sign-compare\
  -Wno-incompatible-pointer-types-discards-qualifiers

APPS_CSOURCES := \
    app_rand.c apps.c asn1pars.c ca.c ciphers.c cms.c crl.c crl2p7.c dgst.c dh.c \
    dhparam.c dsa.c dsaparam.c ec.c ecparam.c enc.c engine.c errstr.c gendh.c gendsa.c \
    genpkey.c genrsa.c nseq.c ocsp.c openssl.c passwd.c pkcs7.c pkcs8.c pkcs12.c \
    pkey.c pkeyparam.c pkeyutl.c prime.c rand.c req.c rsa.c rsautl.c s_cb.c \
    s_socket.c s_time.c sess_id.c smime.c spkac.c srp.c  verify.c \
    version.c vms_decc_init.c x509.c

#ts.c md4.c s_client.c s_server.c  speed.c
#    openssl.c apps.c engine.c s_client.c dgst.c enc.c s_client.c
    #apps.c engine.c s_client.c

APPS_LOCAL_SRC_FILES := $(addprefix apps/,$(APPS_CSOURCES))

APPS_LOCAL_C_INCLUDES += $(LOCAL_PATH) \
                    $(LOCAL_PATH)/include \
                    $(LOCAL_PATH)/ssl \
                    $(LOCAL_PATH)/apps \
                    $(LOCAL_PATH)/crypto \
                    $(LOCAL_PATH)/MacOS

#$(LOCAL_PATH)/crypto/asn1 \
#$(LOCAL_PATH)/crypto/evp \
#$(LOCAL_PATH)/crypto/modes \