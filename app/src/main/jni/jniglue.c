#include <jni.h>
#include <android/log.h>
#include <stdlib.h>
#include <unistd.h>


#include "jniglue.h"

jint JNI_OnLoad(JavaVM *vm, void *reserved) {
#ifndef NDEBUG
    __android_log_write(ANDROID_LOG_DEBUG,"openssl", "Loading openssl native library $id$ compiled on "   __DATE__ " " __TIME__ );
#endif
    return JNI_VERSION_1_2;
}


void android_openvpn_log(int level,const char* prefix,const char* prefix_sep,const char* m1)
{
    __android_log_print(ANDROID_LOG_DEBUG,"openssl","%s%s%s",prefix,prefix_sep,m1);
}

void Java_uz_test_debugnative_tmp_NativeUtils_jniclose(JNIEnv *env,jclass jo, jint fd)
{
	int ret = close(fd);
}

jstring Java_uz_test_debugnative_tmp_NativeUtils_getNativeAPI(JNIEnv *env, jclass jo)
{

    return (*env)->NewStringUTF(env, TARGET_ARCH_ABI);
}
