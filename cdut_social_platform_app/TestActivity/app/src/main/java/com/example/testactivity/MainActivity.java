package com.example.testactivity;

import androidx.appcompat.app.AppCompatActivity;

import android.content.ComponentName;
import android.content.Intent;
import android.content.ServiceConnection;
import android.os.Bundle;
import android.os.Handler;
import android.os.IBinder;
import android.os.Message;
import android.os.Messenger;
import android.os.RemoteException;
import android.util.Log;

public class MainActivity extends AppCompatActivity {
    private final static Handler handler=new Handler(){
        @Override
        public void handleMessage(Message message){
            System.out.print("客户端已收到服务端的消息");
        }

    };
    private final static Messenger mReplyMessager=new Messenger(handler);

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Intent intent=new Intent(MainActivity.this,TestService.class);
        MyServiceConnection myServiceConnection=new MyServiceConnection();
        bindService(intent,myServiceConnection,BIND_AUTO_CREATE);
    }
    private class MyServiceConnection implements ServiceConnection{

        @Override
        public void onServiceConnected(ComponentName componentName, IBinder service) {
            Messenger messenger=new Messenger(service);
            Message msg=Message.obtain();
            msg.replyTo=mReplyMessager;
            try {
                messenger.send(msg);

            }catch (RemoteException e){
                e.printStackTrace();
            }
        }
        @Override
        public void onServiceDisconnected(ComponentName componentName) {

        }
    }


}
