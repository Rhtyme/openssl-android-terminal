/*
 * Copyright (c) 2012-2017 Arne Schwabe
 * Distributed under the GNU GPL v2 with additional terms. For full terms see the file doc/LICENSE.txt
 */

package uz.test.debugnative.tmp;

import android.util.Log;

import org.greenrobot.eventbus.EventBus;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.Collections;
import java.util.LinkedList;
import java.util.regex.Matcher;
import java.util.regex.Pattern;


/**
 * Created by root on 19/06/17.
 */

public class VersionVPNThread implements Runnable {

    String[] argv;

    private Process mProcess;
    private String mNativeDir;
    private boolean useLbPath;

    private String mCacheDir;

    public VersionVPNThread(String[] argv, String mNativeDir, boolean useLbPath, String mCacheDir) {
        this.argv = argv;
        this.mNativeDir = mNativeDir;
        this.useLbPath = useLbPath;
        this.mCacheDir = mCacheDir;
    }

    @Override
    public void run() {
        EventBus.getDefault().post(new MessageEvent(null, TActivity.PROCESS_RUNNING));
        startOpenVPN(argv);
    }

    private void startOpenVPN(String[] argv) {

        // Write OpenVPN binary
        startOpenVPNThreadArgs(argv);

        // Set a flag that we are starting a new VPN
//        mStarting = true;
    }

    private void startOpenVPNThreadArgs(String[] argv) {
        LinkedList<String> argvlist = new LinkedList<String>();

        Collections.addAll(argvlist, argv);

        ProcessBuilder pb = new ProcessBuilder(argvlist);
        // Hack O rama

        if (useLbPath) {
            String lbpath = genLibraryPath(argv, pb);
            pb.environment().put("LD_LIBRARY_PATH", lbpath);
            pb.environment().put("OPENSSL_CONF", mCacheDir);
        }


        pb.redirectErrorStream(true);
        try {
            mProcess = pb.start();
            // Close the output, since we don't need it
            mProcess.getOutputStream().close();
            InputStream in = mProcess.getInputStream();
            BufferedReader br = new BufferedReader(new InputStreamReader(in));

            while (true) {
                String logline = br.readLine();
                if (logline == null) {
                    EventBus.getDefault().post(new MessageEvent(null, TActivity.PROCESS_STOPPED));
                    return;
                }
                Log.d("OPENVPN", logline);
                EventBus.getDefault().post(new MessageEvent(logline));

/*
                if (logline.startsWith(DUMP_PATH_STRING))
                    mDumpPath = logline.substring(DUMP_PATH_STRING.length());

                if (logline.startsWith(BROKEN_PIE_SUPPORT) || logline.contains(BROKEN_PIE_SUPPORT2))
                    mBrokenPie = true;
*/


                // 1380308330.240114 18000002 Send to HTTP proxy: 'X-Online-Host: bla.blabla.com'

                Pattern p = Pattern.compile("(\\d+).(\\d+) ([0-9a-f])+ (.*)");
                Matcher m = p.matcher(logline);
                if (m.matches()) {
                    int flags = Integer.parseInt(m.group(3), 16);
                    String msg = m.group(4);
                    int logLevel = flags & 0x0F;

                    VpnStatus.LogLevel logStatus = VpnStatus.LogLevel.INFO;

/*
                    if ((flags & M_FATAL) != 0)
                        logStatus = VpnStatus.LogLevel.ERROR;
                    else if ((flags & M_NONFATAL) != 0)
                        logStatus = VpnStatus.LogLevel.WARNING;
                    else if ((flags & M_WARN) != 0)
                        logStatus = VpnStatus.LogLevel.WARNING;
                    else if ((flags & M_DEBUG) != 0)
                        logStatus = VpnStatus.LogLevel.VERBOSE;
*/


                    if (msg.startsWith("MANAGEMENT: CMD"))
                        logLevel = Math.max(4, logLevel);


                    VpnStatus.logMessageOpenVPN(logStatus, logLevel, msg);
                } else {
                    VpnStatus.logInfo("P:" + logline);
                }

                if (Thread.interrupted()) {
                    EventBus.getDefault().post(new MessageEvent(null, TActivity.PROCESS_STOPPED));
                    throw new InterruptedException("OpenVpn process was killed form java code");
                }
            }
        } catch (InterruptedException | IOException e) {
            VpnStatus.logException("Error reading from output of OpenVPN process", e);
            EventBus.getDefault().post(new MessageEvent(e.getMessage(), TActivity.PROCESS_STOPPED));
            if (mProcess != null) {
                mProcess.destroy();
            }
        }
    }


    private String genLibraryPath(String[] argv, ProcessBuilder pb) {
        // Hack until I find a good way to get the real library path
        // TODO: 20/06/17 fix then!!!
        String applibpath = argv[0].replaceFirst("/cache/.*$", "/lib");
//        String applibpath = argv[0].replaceFirst("/cache/.*$", "/cache");

        String lbpath = pb.environment().get("LD_LIBRARY_PATH");
        if (lbpath == null)
            lbpath = applibpath;
        else
            lbpath = applibpath + ":" + lbpath;

        if (!applibpath.equals(mNativeDir)) {
            lbpath = mNativeDir + ":" + lbpath;
        }
        return lbpath;
    }


}
