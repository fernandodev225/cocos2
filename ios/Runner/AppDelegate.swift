import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    var rootViewController: FlutterViewController?
    lazy var appController = AppController()
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        window?.rootViewController
        rootViewController = window?.rootViewController as! FlutterViewController
        appController
        let channel = FlutterMethodChannel(name: "channel",
                                           binaryMessenger: rootViewController!.binaryMessenger)
        channel.setMethodCallHandler({
            [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
            print("=================================>")
            print("Hello: " + call.method)
            
            UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
            
            
            
            self?.appController = AppController()
            self?.appController.application(application, didFinishLaunchingWithOptions: launchOptions)
            
//            controller.navigationController?.pushViewController(self!.appController.getController(), animated: true)
            
            
            let navigationController = UINavigationController(rootViewController: self!.appController.getController())
            self?.window.rootViewController = navigationController
            self?.window.makeKeyAndVisible()
            self?.appController.appStart()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                self?.window.rootViewController = self?.rootViewController
                self?.window.makeKeyAndVisible()
            }
        })
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    override func applicationDidEnterBackground(_ application: UIApplication) {
        appController.applicationDidEnterBackground(application)
    }
    
    override func applicationWillEnterForeground(_ application: UIApplication) {
        appController.applicationWillEnterForeground(application)
    }
}
