package com.linkwisdom.onlysdk;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;

import com.linkwisdom.onlylibrary.util.AuthBiz;

public class MainActivity extends AppCompatActivity {

    Button bt1, bt2, bt3, bt4;

    String name, address;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        bt1 = findViewById(R.id.bt1);
        bt2 = findViewById(R.id.bt2);
        bt3 = findViewById(R.id.bt3);
        bt4 = findViewById(R.id.bt4);

        final AuthBiz biz = new AuthBiz(this);

        bt1.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                biz.auth("", "大鲜包子铺");
            }
        });

        bt2.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                biz.recharge(address, address, 1000, "我只是个详情");
            }
        });

        bt3.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                biz.check(name, address, 100, "");
            }
        });

        bt4.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

            }
        });

    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (resultCode == RESULT_OK) {
            switch (requestCode) {
                case AuthBiz.AUTH_APPLY:
                    address = data.getStringExtra("address");
                    name = data.getStringExtra("walletName");
                    Log.e("ramon", address + " , " + " " + name);
                    break;
                case AuthBiz.RECHARGE_APPLY:
                    String action = data.getStringExtra("action");
                    Log.e("ramon", action);

                    break;
                case AuthBiz.CHECK:
                    break;
                default:
                    break;
            }
        }
    }
}