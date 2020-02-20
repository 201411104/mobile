package com.example.mobile;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.BatteryManager;
import android.os.Build.VERSION;
import android.os.Build.VERSION_CODES;
import android.os.Bundle;
import androidx.annotation.NonNull;
import android.telephony.TelephonyManager;
import android.media.AudioManager;
import android.media.AudioDeviceInfo;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.EventChannel.EventSink;
import io.flutter.plugin.common.EventChannel.StreamHandler;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.MethodCall;
import io.flutter.embedding.android.FlutterFragmentActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterFragmentActivity {
  private static final String BATTERY_CHANNEL = "pineapple.flutter.io/battery";
  private static final String CHARGING_CHANNEL = "pineapple.flutter.io/charging";
  private static final String SIM_CHANNEL = "pineapple.flutter.io/sim";
  private static final String HEADSET_CHANNEL = "pineapple.flutter.io/headset";

  @Override
  public void configureFlutterEngine(@NonNull final FlutterEngine flutterEngine) {
    GeneratedPluginRegistrant.registerWith(flutterEngine);

    new EventChannel(flutterEngine.getDartExecutor(), CHARGING_CHANNEL).setStreamHandler(
      new StreamHandler() {
        private BroadcastReceiver chargingStateChangeReceiver;
        @Override
        public void onListen(final Object arguments, final EventSink events) {
          chargingStateChangeReceiver = createChargingStateChangeReceiver(events);
          registerReceiver(
              chargingStateChangeReceiver, new IntentFilter(Intent.ACTION_BATTERY_CHANGED));
        }

        @Override
        public void onCancel(final Object arguments) {
          unregisterReceiver(chargingStateChangeReceiver);
          chargingStateChangeReceiver = null;
        }
      }
    );

    new EventChannel(flutterEngine.getDartExecutor(), HEADSET_CHANNEL).setStreamHandler(

      new StreamHandler() {
        private BroadcastReceiver headsetStateChangeReceiver;
        @Override
        public void onListen(final Object arguments, final EventSink events) {
          
        }
        @Override
        public void onCancel(Object arguments) {
        }
      }
    );

    new MethodChannel(flutterEngine.getDartExecutor(), BATTERY_CHANNEL).setMethodCallHandler(
      new MethodCallHandler() {
        @Override
        public void onMethodCall(final MethodCall call, final Result result) {
          if (call.method.equals("getBatteryLevel")) {
            final int batteryLevel = getBatteryLevel();

            if (batteryLevel != -1) {
              result.success(batteryLevel);
            } else {
              result.error("UNAVAILABLE", "Battery level not available.", null);
            }
          } else {
            result.notImplemented();
          }
        }
      }
    );

    new MethodChannel(flutterEngine.getDartExecutor(), SIM_CHANNEL).setMethodCallHandler(
      new MethodCallHandler(){
        @Override
        public void onMethodCall(final MethodCall call, final Result result){
          if(call.method.equals("CarrierName")){
            result.success(getCarrierName());
          }
        }
      }
    );

    new MethodChannel(flutterEngine.getDartExecutor(), HEADSET_CHANNEL).setMethodCallHandler(
      new MethodCallHandler(){
        @Override
        public void onMethodCall(final MethodCall call, final Result result){
          if(call.method.equals("headsetInfo")){
            result.success(getHeadsetInfo());
          }
        }
      }
    );


  }

  private BroadcastReceiver createChargingStateChangeReceiver(final EventSink events) {
    return new BroadcastReceiver() {
      @Override
      public void onReceive(final Context context, final Intent intent) { 
        final int status = intent.getIntExtra(BatteryManager.EXTRA_STATUS, -1);

        if (status == BatteryManager.BATTERY_STATUS_UNKNOWN) {
          events.error("UNAVAILABLE", "Charging status unavailable", null);
        } else {
          final boolean isCharging = status == BatteryManager.BATTERY_STATUS_CHARGING ||
                               status == BatteryManager.BATTERY_STATUS_FULL;
          events.success(isCharging ? "charging" : "discharging");
        }
      }
    };
  }

  private int getBatteryLevel() {
    if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
      final BatteryManager batteryManager = (BatteryManager) getSystemService(BATTERY_SERVICE);
      return batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY);
    } else {
      final Intent intent = new ContextWrapper(getApplicationContext()).
          registerReceiver(null, new IntentFilter(Intent.ACTION_BATTERY_CHANGED));
      return (intent.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100) /
          intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1);
    }
  }
  private String getCarrierName(){
    final TelephonyManager mTelephonyManager = (TelephonyManager) getSystemService(TELEPHONY_SERVICE);
    final String networkOperatorName = mTelephonyManager.getNetworkOperatorName();
    System.out.println(networkOperatorName);
    return networkOperatorName;
  }

  private boolean getHeadsetInfo(){
    final AudioManager mAudioManager = (AudioManager) getSystemService(AUDIO_SERVICE);
    final AudioDeviceInfo[] audioDevices = mAudioManager.getDevices(AudioManager.GET_DEVICES_ALL);
    for(final AudioDeviceInfo deviceInfo : audioDevices){
      if(deviceInfo.getType()==AudioDeviceInfo.TYPE_WIRED_HEADPHONES
              || deviceInfo.getType()==AudioDeviceInfo.TYPE_WIRED_HEADSET){
          return true;
      }
    }
    return false;
  }
}