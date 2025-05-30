import UIKit
import Flutter
import FirebaseCore
import Firebase
import FirebaseMessaging
import UserNotifications

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, MessagingDelegate {

    private var fcmToken: String?

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // Configure Firebase
        FirebaseApp.configure()

        // Set UNUserNotificationCenter delegate
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
        Messaging.messaging().delegate = self

        // Register Flutter plugins
        GeneratedPluginRegistrant.register(with: self)

        // Set up MethodChannel to receive FCM token from Flutter
        if let controller = window?.rootViewController as? FlutterViewController {
            let apiChannel = FlutterMethodChannel(name: "native_service", binaryMessenger: controller.binaryMessenger)

            apiChannel.setMethodCallHandler { [weak self] (call, result) in
                if call.method == "startService" {
                    if let args = call.arguments as? [String: Any],
                       let token = args["token"] as? String {
                        self?.fcmToken = token
                        print("Received FCM token from Flutter: \(token)")
                    }
                    result(nil)
                } else {
                    result(FlutterMethodNotImplemented)
                }
            }
        }

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    override func applicationWillTerminate(_ application: UIApplication) {
        super.applicationWillTerminate(application)

        print("App will terminate, attempting API call with FCM token...")

        guard let token = fcmToken else {
            print("No FCM token available, skipping API call on termination.")
            return
        }

        callApiWithFcmToken(token)
    }

    private func callApiWithFcmToken(_ token: String) {
        guard let url = URL(string: "http://board.mvp.design-wisdom.com/api/app-logout") else {
            print("Invalid API URL.")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let jsonBody: [String: Any] = [
            "device_token": token
        ]

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: jsonBody, options: [])
            request.httpBody = jsonData
        } catch {
            print("Failed to serialize JSON body: \(error)")
            return
        }

        let semaphore = DispatchSemaphore(value: 0)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("API call error on app termination: \(error)")
            } else if let httpResponse = response as? HTTPURLResponse {
                print("API call response code: \(httpResponse.statusCode)")
                let defaults = UserDefaults.standard
                if let appDomain = Bundle.main.bundleIdentifier {
                    defaults.removePersistentDomain(forName: appDomain)
                    defaults.synchronize()
                    print("✅ Cleared all UserDefaults data after successful logout.")
                }
            }
            semaphore.signal()
        }

        task.resume()

        // Wait up to 15 seconds for the API call to complete
        let timeoutResult = semaphore.wait(timeout: .now() + 15)
        if timeoutResult == .timedOut {
            print("API call timed out waiting on app termination.")
        } else {
            print("API call completed on app termination.")
        }
    }

    override func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        Messaging.messaging().apnsToken = deviceToken
    }

    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("✅ Firebase registration token received: \(fcmToken ?? "nil")")
        // You can send this token to your server if needed
    }
}
