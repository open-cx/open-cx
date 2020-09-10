package pt.up.fe.communio;

import android.bluetooth.BluetoothAdapter;
import android.content.Context;
import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  private static final String CHANNEL = "pt.up.fe.communio";

  @Override
  public void onCreate(Bundle savedInstanceState) {

    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);

    new MethodChannel(getFlutterView(), CHANNEL)
        .setMethodCallHandler(new MethodCallHandler() {
          @Override
          public void onMethodCall(MethodCall call, Result result) {
            if (call.method.equals("getLocalBluetoothName")){
              result.success(getLocalBluetoothName());
            } else{
              result.notImplemented();
            }
          }
        });
  }

  public String getLocalBluetoothName() {
    BluetoothAdapter mBluetoothAdapter = BluetoothAdapter.getDefaultAdapter();
    String name = mBluetoothAdapter.getName();
    if (name == null) {
      System.out.println("Name is null!");
      name = mBluetoothAdapter.getAddress();
    }
    return name;
  }
}
