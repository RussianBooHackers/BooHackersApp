import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let dictionary = NSDictionary(contentsOfFile: Bundle.main.pathForResource("boohack", ofType: "plist")!);
    let mapKey = dictionary?["mapKey"]
    GMSServices.provideAPIKey(mapKey)
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
