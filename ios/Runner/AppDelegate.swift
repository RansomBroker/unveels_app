import UIKit
import Flutter
import Firebase
import GoogleMaps
import Firebase
import QuickLook
import AuthenticationServices
import SwiftKeychainWrapper


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    private var _latestLink: String?
    var displayLink : CADisplayLink?

    private var latestLink: String? {
        get {
            _latestLink
        }
        set(latestLink) {

            _latestLink = latestLink
            if _eventSink != nil {
                _eventSink?(_latestLink)
            }
        }
    }

        private var _eventSink: FlutterEventSink?
    var fileURL: URL!
    var  result: FlutterResult?
    
    @objc func displayLinkCallback() {
            // let workingTime = displayLink!.targetTimestamp - CACurrentMediaTime()
           // At this moment in time, there are `workingTime` seconds available to
           // generate content for the next frame, so
           // Core Animation can render it to the display.
       }

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      displayLink = CADisplayLink(target: self, selector: #selector(displayLinkCallback))
          displayLink!.add(to: .current, forMode: .default)
            if #available(iOS 15.0, *) {
                displayLink!.preferredFrameRateRange = CAFrameRateRange(minimum:120, maximum:120, preferred:120)
            } else {
                // Fallback on earlier versions
            }
    FirebaseApp.configure()
    GMSServices.provideAPIKey("AIzaSyBeiA-roDfnkvzNhklKwTGYvdxxpeNXPB4")
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let mlkitChannel = FlutterMethodChannel(name: "com.webkul.magento_mobikul/channel",
                                                  binaryMessenger: controller.binaryMessenger)
    mlkitChannel.setMethodCallHandler({
          (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
        if call.method == "imageSearch"{
            let vc = MLKitViewController(nibName: "MLKitViewController", bundle: nil)
            vc.detectorType =  .image
            vc.modalPresentationStyle = .overFullScreen
            vc.suggestedData = { data in
                result(data)
            }
            controller.present(vc, animated: true, completion: nil)
            
        } else if call.method == "textSearch"{
            let vc = MLKitViewController(nibName: "MLKitViewController", bundle: nil)
            vc.detectorType = .text
            vc.modalPresentationStyle = .overFullScreen
            vc.suggestedData = { data in
                result(data)
            }
            controller.present(vc, animated: true, completion: nil)
            
        } else if call.method == "fileviewer"{
            if let urlString = call.arguments as? String, let url = self.showFileWithPath(urlString){
                self.fileURL = url
                let previewController = QLPreviewController()
                previewController.dataSource = self
                previewController.delegate = self
                previewController.modalPresentationStyle = .fullScreen
                controller.present(previewController, animated: true, completion: nil)
            }
        } else if call.method == "appleSignin"{
                        self.result = result
                        if #available(iOS 13.0, *) {
                            let request = ASAuthorizationAppleIDProvider().createRequest()
                            request.requestedScopes = [.fullName, .email]
                            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
                            authorizationController.delegate = self
                            authorizationController.presentationContextProvider = self
                            authorizationController.performRequests()
                        }
                    }

        })

    let chargingChannel = FlutterEventChannel(
        name: "uni_links/events",
        binaryMessenger: controller.binaryMessenger)
    chargingChannel.setStreamHandler(self)


    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    func showFileWithPath(_ path: String) -> URL?{
        if let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
        print(documentsUrl)
        let destinationFileUrl = documentsUrl.appendingPathComponent(path)
        print(destinationFileUrl)
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: destinationFileUrl.path) {
            print("FILE AVAILABLE")
            return destinationFileUrl
        }
       }
        return nil
    }
    override func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {

        if userActivity.activityType == "NSUserActivityTypeBrowsingWeb" {
            print(userActivity.webpageURL as Any)
            setLatestLink(userActivity.webpageURL?.description)
        }
        return true
    }
}

extension AppDelegate: QLPreviewControllerDelegate, QLPreviewControllerDataSource {
    override func application(_ application: UIApplication, willContinueUserActivityWithType userActivityType: String) -> Bool {
        print(#function)
        print(userActivityType)
        return true
    }
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }

    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        let url = fileURL
        return url! as QLPreviewItem
    }

}

extension AppDelegate: FlutterStreamHandler {
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        _eventSink = events
        return nil
    }

    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        _eventSink = nil
        return nil
    }
    func setLatestLink(_ latestLink: String?) {
        self.latestLink = latestLink
        if (_eventSink != nil) {
            _eventSink?(self.latestLink)
        }
    }
}
enum Keys: String {
    case fname
    case lname
    case email
    case userID
    case personID
}
@available(iOS 13.0, *)
extension AppDelegate: ASAuthorizationControllerDelegate {
    private var fourDigitNumber: String {
        var result = ""
        repeat {
            // Create a string with a random number 0...9999
            result = String(format:"%04d", arc4random_uniform(10000) )
        } while Set<Character>(result).count < 4
        return result
    }
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential else {
            return
        }
        var socialParams = [String: Any]()
        if let _ = appleIDCredential.email, let _ = appleIDCredential.fullName {
            var status = false
            if KeychainWrapper.standard.set(appleIDCredential.email!, forKey: Keys.email.rawValue) {
                status = true
            }
            if KeychainWrapper.standard.set(appleIDCredential.fullName?.givenName ?? "Test", forKey: Keys.fname.rawValue) {
                status = true
            }
            if KeychainWrapper.standard.set(appleIDCredential.fullName?.familyName ?? "Test", forKey: Keys.lname.rawValue) {
                status = true
            }
            if status {
                socialParams["firstname"] = appleIDCredential.fullName?.givenName
                socialParams["lastname"] = appleIDCredential.fullName?.familyName
                let key = self.fourDigitNumber
                KeychainWrapper.standard.set(key, forKey: Keys.personID.rawValue)
                socialParams["email"] = appleIDCredential.email
                socialParams["pictureURL"] = ""
                self.result?(socialParams)
            }
        }else {
            //socialParams["wk_token"] = sharedPrefrence.object(forKey:"wk_token");
            socialParams["firstname"] = KeychainWrapper.standard.string(forKey: Keys.fname.rawValue)
            socialParams["lastname"] = KeychainWrapper.standard.string(forKey: Keys.lname.rawValue)
            // socialParams["personId"] = KeychainWrapper.standard.string(forKey: Keys.personID.rawValue)
            socialParams["email"] = KeychainWrapper.standard.string(forKey: Keys.email.rawValue)
            socialParams["pictureURL"] = ""
            self.result?(socialParams)
        }
    }


    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        //   NetworkManager.sharedInstance.showErrorSnackBar(msg: error.localizedDescription)
        print("AppleID Credential failed with error: \(error.localizedDescription)")
    }
}

@available(iOS 13.0, *)
extension AppDelegate: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.window!
    }
}

