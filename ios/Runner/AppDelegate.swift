import UIKit
import Flutter
import CoreTelephony

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let simChannel = FlutterMethodChannel(name: "pineapple.flutter.dev/sim", binaryMessenger: controller.binaryMessenger)

    simChannel.setMethodCallHandler({
      [weak self](call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      guard call.method == "getSimInfo" else{
        result(FlutterMethodNotImplemented)
        return
      }
      self?.receiveSimInfo(result: result)
    })

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func receiveSimInfo(result: FlutterResult){
    let netinfo = CTTelephonyNetworkInfo()
    if let carrier = netinfo.subscriberCellularProvider{
      result(carrier.carrierName)
    }
  }


}
