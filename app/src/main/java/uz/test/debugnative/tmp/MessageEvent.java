/*
 * Copyright (c) 2012-2017 Arne Schwabe
 * Distributed under the GNU GPL v2 with additional terms. For full terms see the file doc/LICENSE.txt
 */

package uz.test.debugnative.tmp;

/**
 * Created by root on 13/06/17.
 */

public class MessageEvent {

    private String msg;
    private int iMsg;

    public MessageEvent(String msg) {
        this.msg = msg;
    }

    public MessageEvent(String msg, int iMsg) {
        this.msg = msg;
        this.iMsg = iMsg;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public int getiMsg() {
        return iMsg;
    }

    public void setiMsg(int iMsg) {
        this.iMsg = iMsg;
    }
}
