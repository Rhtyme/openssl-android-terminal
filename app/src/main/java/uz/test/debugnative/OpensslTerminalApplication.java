/*
 * Copyright (c) 2012-2016 Arne Schwabe
 * Distributed under the GNU GPL v2 with additional terms. For full terms see the file doc/LICENSE.txt
 */

package uz.test.debugnative;

import android.app.Application;
import android.content.Context;
import android.util.Log;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;


public class OpensslTerminalApplication extends Application {

    private static Context context;
    @Override
    public void onCreate() {
        super.onCreate();
        context = OpensslTerminalApplication.this;
    }

    public static Context getContext() {
        return context;
    }

    public void setupConDirs() {
        trimCache(OpensslTerminalApplication.this);

        Log.d("openssl", "cache: " + getCacheDir().getPath());
        Log.d("openssl", "nativeDir: " + getApplicationInfo().nativeLibraryDir);

        try {
            copyOCnf(getCacheDir().getPath() + "/", "openssl.cnf");
//            copyOCnf(getApplicationInfo().nativeLibraryDir + "/", "openssl.cnf");
//            copyOCnf(getCacheDir().getPath() + "/", "gost.crt");
//            copyOCnf(getCacheDir().getPath() + "/", "ca.pem");
//            copyOCnf(getCacheDir().getPath() + "/", "gost.key");
            String gdbDir = getCacheDir().getPath() + "/lib";
            boolean success = new File(gdbDir).mkdirs();
            if (success)
                copyOCnf(gdbDir + "/", "gdbserver");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void trimCache(Context context) {
        try {
            File dir = context.getCacheDir();
            if (dir != null && dir.isDirectory()) {
                deleteDir(dir);
            }
        } catch (Exception e) {
            // TODO: handle exception
        }
    }

    public static boolean deleteDir(File dir) {
        if (dir != null && dir.isDirectory()) {
            String[] children = dir.list();
            for (int i = 0; i < children.length; i++) {
                boolean success = deleteDir(new File(dir, children[i]));
                if (!success) {
                    return false;
                }
            }
        }

        // The directory is now empty so delete it
        if (dir.canExecute()) {
            return dir.delete();
        }
        return true;
//        return dir.delete();
    }

    public void copyOCnf(String path, String fName) throws IOException {
        if (new File(path + fName).exists()) {
            return;
        }
        OutputStream myOutput = new FileOutputStream(path + fName);
        byte[] buffer = new byte[1024];
        int length;
        InputStream myInput = getAssets().open(fName);
        while ((length = myInput.read(buffer)) > 0) {
            myOutput.write(buffer, 0, length);
        }
        Log.d("openssl", "crt file path: " + new File(path + fName).getPath());
        Log.d("openssl", "path: " + path + fName);

        myInput.close();
        myOutput.flush();
        myOutput.close();

    }


}
