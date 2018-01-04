/*
 * Copyright (c) 2012-2017 Arne Schwabe
 * Distributed under the GNU GPL v2 with additional terms. For full terms see the file doc/LICENSE.txt
 */

package uz.test.debugnative.tmp;

import android.Manifest;
import android.annotation.TargetApi;
import android.app.Activity;
import android.content.pm.PackageManager;
import android.os.Build;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ScrollView;
import android.widget.TextView;

import org.greenrobot.eventbus.EventBus;
import org.greenrobot.eventbus.Subscribe;
import org.greenrobot.eventbus.ThreadMode;

import uz.test.debugnative.ICSOpenVPNApplication;
import uz.test.debugnative.R;

/**
 * Created by root on 19/06/17.
 */

public class TActivity extends Activity {

    TextView tvConsole;
    EditText edConsole;
    Button btnEnter;
    ScrollView scrollView;

    int PROCESS_STATE;
    public final static int PROCESS_RUNNING = 100;
    public final static int PROCESS_STOPPED = 101;

    private static final int PERMISSION_REQUEST = 23621;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.t_activity);
        checkoutPermission();

        tvConsole = (TextView) findViewById(R.id.tv_console);
        edConsole = (EditText) findViewById(R.id.ed_console);
        btnEnter = (Button) findViewById(R.id.btn_enter);
        scrollView = (ScrollView) findViewById(R.id.sc_main);
        PROCESS_STATE = PROCESS_STOPPED;
        addTextToConsole("Console version 1.0 beta.\nAll Rights copyright.\n" +
                "(Sirojiddin Komolov. @alpteam!!!)");

        btnEnter.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                sendCommand();
            }
        });
    }

    private void checkoutPermission() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M)
            checkPermission();
    }


    @TargetApi(Build.VERSION_CODES.M)
    private void checkPermission() {
        if (checkSelfPermission(Manifest.permission.READ_EXTERNAL_STORAGE) != PackageManager.PERMISSION_GRANTED ||
                checkSelfPermission(Manifest.permission.WRITE_EXTERNAL_STORAGE) != PackageManager.PERMISSION_GRANTED) {
            requestPermissions(new String[]{
                            Manifest.permission.READ_EXTERNAL_STORAGE,
                            Manifest.permission.WRITE_EXTERNAL_STORAGE
                    },
                    PERMISSION_REQUEST);
        } else {
            ((ICSOpenVPNApplication) getApplication()).setupConDirs();
        }
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, String[] permissions, int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        checkoutPermission();
/*        if (grantResults[0] == PackageManager.PERMISSION_DENIED) {
            checkoutPermission();
*//*
            if (mNoInline) {
                setResult(RESULT_CANCELED);
                finish();
            } else {
                if (fileExplorerTab!=null)
                    getActionBar().removeTab(fileExplorerTab);
            }
*//*
        } else {
//            mFSFragment.refresh();
        }*/
    }

    private void sendCommand() {
        String cm = edConsole.getText().toString();
        if (cm.isEmpty()) {
            return;
        }
        addTextToConsole(cm);
        edConsole.getText().clear();
        String[] args = cm.split("\\s");
        switch (args[0]) {
            case "openssl":
                sendOpenSSLCommand(args);
                break;
            default:
                addTextToConsole("sorry, I can not handle this command :(");
        }
    }

    private void sendOpenSSLCommand(String[] opvArgs) {
        String nativeLibraryDirectory = getApplicationInfo().nativeLibraryDir;

        String binaryName = VPNLaunchHelper.writeBinaryByType(getBaseContext(),
                VPNLaunchHelper.EXE_TYPE.OPENSSL);


        if (binaryName == null) {
            addTextToConsole("sorry native library not found :(");
            return;
        }
        addTextToConsole("nativeLibDir: " + nativeLibraryDirectory);
        addTextToConsole("binaryName: " + binaryName);
        opvArgs[0] = binaryName;
        new Thread(new VersionVPNThread(opvArgs, nativeLibraryDirectory, true,
                getCacheDir().getPath())).start();
    }


    public void addTextToConsole(String text) {
        if (text == null) {
            return;
        }
        tvConsole.append(text);
        tvConsole.append("\n");
        scrollView.post(new Runnable() {
            public void run() {
                scrollView.fullScroll(View.FOCUS_DOWN);
            }
        });
    }

    @Subscribe(threadMode = ThreadMode.MAIN)
    public void onMessageEvent(MessageEvent event) {
        if (event.getiMsg() != 0) {
            PROCESS_STATE = event.getiMsg();

            addTextToConsole("---PROCESS " +
                    (PROCESS_STATE == PROCESS_RUNNING ? "RUNNING" : "STOPPED") + "---");
        }
        addTextToConsole(event.getMsg());
        if (PROCESS_STATE == PROCESS_RUNNING) {
            edConsole.setEnabled(false);
        } else if (PROCESS_STATE == PROCESS_STOPPED) {
            edConsole.setEnabled(true);
        }

        /* Do something */
    }

    @Override
    public void onStart() {
        super.onStart();
        EventBus.getDefault().register(this);
    }

    @Override
    public void onStop() {
        super.onStop();
        EventBus.getDefault().unregister(this);
    }

}
