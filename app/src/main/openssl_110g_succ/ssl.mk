SSL_CSOURCES := \
  ssl/bio_ssl.c \
  ssl/d1_lib.c \
  ssl/d1_msg.c \
  ssl/d1_srtp.c \
  ssl/methods.c \
  ssl/pqueue.c \
  ssl/record/dtls1_bitmap.c \
  ssl/record/rec_layer_d1.c \
  ssl/record/rec_layer_s3.c \
  ssl/record/ssl3_buffer.c \
  ssl/record/ssl3_record.c \
  ssl/s3_cbc.c \
  ssl/s3_enc.c \
  ssl/s3_lib.c \
  ssl/s3_msg.c \
  ssl/ssl_asn1.c \
  ssl/ssl_cert.c \
  ssl/ssl_ciph.c \
  ssl/ssl_conf.c \
  ssl/ssl_err.c \
  ssl/ssl_init.c \
  ssl/ssl_lib.c \
  ssl/ssl_mcnf.c \
  ssl/ssl_rsa.c \
  ssl/ssl_sess.c \
  ssl/ssl_stat.c \
  ssl/ssl_txt.c \
  ssl/ssl_utst.c \
  ssl/statem/statem.c \
  ssl/statem/statem_clnt.c \
  ssl/statem/statem_dtls.c \
  ssl/statem/statem_lib.c \
  ssl/statem/statem_srvr.c \
  ssl/t1_enc.c \
  ssl/t1_ext.c \
  ssl/t1_lib.c \
  ssl/t1_reneg.c \
  ssl/t1_trce.c \
  ssl/tls_srp.c \

SSL_LOCAL_SRC_FILES := $(SSL_CSOURCES)
#$(addprefix ssl/,$(SSL_CSOURCES))

SSL_LOCAL_C_INCLUDES := \
  $(LOCAL_PATH)/include \
  $(LOCAL_PATH)/. \
  $(LOCAL_PATH)/crypto
#  $(NDK_PATH)/platforms/$(TARGET_PLATFORM)/arch-arm/usr/include

LOCAL_C_INCLUDES += $(SSL_LOCAL_C_INCLUDES)
LOCAL_SRC_FILES += $(SSL_LOCAL_SRC_FILES)
