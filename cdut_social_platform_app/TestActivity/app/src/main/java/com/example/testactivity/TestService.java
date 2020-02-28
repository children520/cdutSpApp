package com.example.testactivity;

import android.app.Service;
import android.content.Intent;
import android.os.Handler;
import android.os.IBinder;
import android.os.Message;
import android.os.Messenger;
import android.os.RemoteException;

public class TestService extends Service {

    private final static Handler mHandler=new Handler(){
        @Override
        public void  handleMessage(Message message){
            System.out.println("客户端，听到请回答");
            Messenger messenger=message.replyTo;
            Message msg_reply=Message.obtain();
            try{
                messenger.send(msg_reply);
            }catch (RemoteException e){
                e.printStackTrace();
            }
        }
    };
    private final static Messenger mMessenger=new Messenger(mHandler);
    public TestService() {

    }

    @Override
    public IBinder onBind(Intent intent) {
        return mMessenger.getBinder();
    }


}
