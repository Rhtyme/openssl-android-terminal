/*
 * Copyright (c) 2012-2016 Arne Schwabe
 * Distributed under the GNU GPL v2 with additional terms. For full terms see the file doc/LICENSE.txt
 */

package uz.test.debugnative.tmp;

import android.annotation.TargetApi;
import android.content.Context;
import android.content.Intent;
import android.os.Build;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Arrays;
import java.util.Vector;

import uz.test.debugnative.R;

public class VPNLaunchHelper {

    private static final String OVPNCONFIGFILE = "android.conf";
    private static final String OPENSSL_GAPPS = "gapps_exec";

    public enum EXE_TYPE {
        OPENSSL
    }

    public static String writeBinaryByType(Context context, EXE_TYPE exe_type) {
        String[] abis;
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP)
            abis = getSupportedABIsLollipop();
        else
            //noinspection deprecation
            abis = new String[]{Build.CPU_ABI, Build.CPU_ABI2};

        String nativeAPI = NativeUtils.getNativeAPI();
        if (!nativeAPI.equals(abis[0])) {
            VpnStatus.logWarning(R.string.abi_mismatch, Arrays.toString(abis), nativeAPI);
            abis = new String[]{nativeAPI};
        }

        for (String abi : abis) {
            File vpnExecutable = new File(context.getCacheDir(), getExecByType(exe_type) + "." + abi);
            if ((vpnExecutable.exists() && vpnExecutable.canExecute())
                    || writeSherBuvaHelloBinary(context, abi, vpnExecutable, exe_type)) {
                return vpnExecutable.getPath();
            }
        }
        return null;
    }

    private static boolean writeSherBuvaHelloBinary(Context context, String abi, File mvpnout,
                                                    EXE_TYPE exe_type) {
        try {
            InputStream mvpn;

            try {
                mvpn = context.getAssets().open(getExecByType(exe_type) + "." + abi);
            } catch (IOException errabi) {
                VpnStatus.logInfo("Failed getting assets for archicture " + abi);
                return false;
            }


            FileOutputStream fout = new FileOutputStream(mvpnout);

            byte buf[] = new byte[4096];

            int lenread = mvpn.read(buf);
            while (lenread > 0) {
                fout.write(buf, 0, lenread);
                lenread = mvpn.read(buf);
            }
            fout.close();

            if (!mvpnout.setExecutable(true)) {
                VpnStatus.logError("Failed to make OpenVPN executable");
                return false;
            }


            return true;
        } catch (IOException e) {
            VpnStatus.logException(e);
            return false;
        }

    }

    private static String getExecByType(EXE_TYPE exe_type) {
        switch (exe_type) {
            case OPENSSL:
                return OPENSSL_GAPPS;
        }
        return null;
    }

    @TargetApi(Build.VERSION_CODES.LOLLIPOP)
    private static String[] getSupportedABIsLollipop() {
        return Build.SUPPORTED_ABIS;
    }

    public static String getConfigFilePath(Context context) {
        return context.getCacheDir().getAbsolutePath() + "/" + OVPNCONFIGFILE;
    }

}
