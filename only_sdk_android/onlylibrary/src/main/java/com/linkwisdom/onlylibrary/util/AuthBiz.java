package com.linkwisdom.onlylibrary.util;

import android.app.Activity;
import android.content.Intent;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.widget.Toast;

import androidx.fragment.app.Fragment;

import com.linkwisdom.onlylibrary.base.AppListener;
import com.linkwisdom.onlylibrary.base.Constant;

import java.util.List;

/**
 * Description: 授权相关工具类
 * Author: RAMON
 * CreateDate: 2020/10/19 4:46 PM
 * UpdateUser:
 * UpdateDate:
 * UpdateRemark:
 * Version:
 */
public class AuthBiz {

    private Activity activity;
    private Fragment fragment;

    public static final int AUTH_APPLY = 101;
    public static final int RECHARGE_APPLY = 102;
    public static final int CHECK = 103;

    private AppListener listener;

    public AuthBiz(final Activity activity) {
        this.activity = activity;
        this.listener = new AppListener() {
            @Override
            public void isHas() {

            }

            @Override
            public void nohas() {
                Toast.makeText(activity.getApplicationContext(),"未安装ONLY钱包",Toast.LENGTH_SHORT).show();
            }
        };
    }
    public AuthBiz(final Fragment fragment) {
        this.fragment = fragment;
        this.listener = new AppListener() {
            @Override
            public void isHas() {

            }
            @Override
            public void nohas() {
                Toast.makeText(fragment.getContext(),"未安装ONLY钱包",Toast.LENGTH_SHORT).show();
            }
        };
    }

    public AuthBiz(Activity activity, AppListener listener) {
        this.activity = activity;
        this.listener = listener;
    }
    public AuthBiz(Fragment fragment, AppListener listener) {
        this.fragment = fragment;
        this.listener = listener;
    }

    //跳转申请授权
    public void auth(String logoIcon, String appName) {
        if (checkApp()) {
            listener.isHas();
        } else {
            listener.nohas();
            return;
        }
        Intent sendIntent = new Intent();
        sendIntent.setAction("com.onlychain.octoken.auth");
        String type = "text/plain";
        sendIntent.setType(type);
        sendIntent.putExtra("appName", appName);
        sendIntent.putExtra("logoIcon", logoIcon);
        if (activity!=null) {
            activity.startActivityForResult(sendIntent, AUTH_APPLY);
        }else {
            fragment.startActivityForResult(sendIntent, AUTH_APPLY);
        }
    }

    /**
      * @ProjectName:    NBN
      * @ClassName:      AuthBiz
      * @Description:    AuthBiz.java
      * @Author:         赵峰（zhaofengcto@foxmail.com）
      * @CreateDate:     2020/11/19 10:23
      * @UpdateUser:     更新者
      * @UpdateDate:     2020/11/19 10:23
      * @UpdateRemark:   更新说明
      * @Version:        1.0
     */
    /**
     *
     * @param payAddress 付款地址
     * @param targetAddress 收款地址
     * @param value 金额
     * @param details 其他
     */
    public void recharge(String payAddress,String targetAddress, double value, String details) {

        if (checkApp()) {
            listener.isHas();
        } else {
            listener.nohas();
            return;
        }
        //详细设置跳转
        Intent sendIntent = new Intent();
        sendIntent.setAction("com.onlychain.octoken.recharge");
        String type = "text/plain";
        sendIntent.setType(type);
        sendIntent.putExtra("payAddress", payAddress);
        sendIntent.putExtra("targetAddress", targetAddress);
        sendIntent.putExtra("value", value);
        sendIntent.putExtra("details", details);
        if (activity!=null) {
            activity.startActivityForResult(sendIntent, RECHARGE_APPLY);
        }else {
            fragment.startActivityForResult(sendIntent, RECHARGE_APPLY);
        }

    }

    //跳转申请体现
    public void check(String payAddress,String targetAddress, double value, String details) {
        if (checkApp()) {
            listener.isHas();
        } else {
            listener.nohas();
            return;
        }
        //详细设置跳转
        Intent sendIntent = new Intent();
        sendIntent.setAction("com.onlychain.octoken.check");
        String type = "text/plain";
        sendIntent.setType(type);
        sendIntent.putExtra("payAddress", payAddress);
        sendIntent.putExtra("targetAddress", targetAddress);
        sendIntent.putExtra("value", value);
        sendIntent.putExtra("details", details);
        if (activity!=null) {
            activity.startActivityForResult(sendIntent, CHECK);
        }else {
            fragment.startActivityForResult(sendIntent, CHECK);
        }
    }

    /**
     * 验证是否有APP
     *
     * @return 是否已安装App
     */
    public boolean checkApp() {
        PackageManager packageManager = null;
        if (activity!=null) {
            packageManager = activity.getPackageManager();
        }else {
            packageManager = fragment.getActivity().getPackageManager();
        }

        if (packageManager==null){
            return false;
        }
        List<PackageInfo> pInfo = packageManager.getInstalledPackages(0);
        boolean isHave = false;
        String packageName = "";
        packageName = "com.onlychain.octoken";
        for (int i = 0; i < pInfo.size(); i++) {
            String pn = pInfo.get(i).packageName;
            if (pn.equals(packageName)) {
                isHave = true;
            }
        }
        return isHave;
    }
}
