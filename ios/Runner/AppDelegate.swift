import UIKit
import Flutter
import FirebaseCore
import Firebase
import FirebaseMessaging
import UserNotifications

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {

    private let CHANNEL = "native_service"
    private var fcmToken: String? = nil

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        FirebaseApp.configure()

        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: { _, _ in }
            )
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }

        application.registerForRemoteNotifications()

        GeneratedPluginRegistrant.register(with: self)

        let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
        let channel = FlutterMethodChannel(name: CHANNEL, binaryMessenger: controller.binaryMessenger)

        channel.setMethodCallHandler { [weak self] (call, result) in
            if call.method == "saveToken" {
                if let args = call.arguments as? [String: Any],
                   let token = args["token"] as? String {
                    self?.fcmToken = token
                    UserDefaults.standard.set(token, forKey: "fcm_token")
                    print("FCM token saved from Flutter: \(token)")
                }
                result(nil)
            }
        }

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    override func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        Messaging.messaging().apnsToken = deviceToken
    }

    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Received FCM token: \(fcmToken ?? "")")
    }

    override func applicationWillTerminate(_ application: UIApplication) {
        logoutFromServer()
    }

    // Optional: log out when app goes to background
    override func applicationDidEnterBackground(_ application: UIApplication) {
        logoutFromServer()
    }

    private func logoutFromServer() {
        guard let token = UserDefaults.standard.string(forKey: "fcm_token") else {
            print("No FCM token saved.")
            return
        }

        let url = URL(string: "http://board.mvp.design-wisdom.com/api/app-logout")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: String] = ["device_token": token]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Logout error: \(error.localizedDescription)")
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                print("Logout response code: \(httpResponse.statusCode)")
            }

            if let data = data, let body = String(data: data, encoding: .utf8) {
                print("Logout response body: \(body)")
            }

            UserDefaults.standard.removeObject(forKey: "fcm_token")
        }

        task.resume()
    }
}