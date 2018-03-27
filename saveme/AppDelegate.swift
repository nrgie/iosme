import UIKit
import SwiftyJSON
import Fabric
import Crashlytics
import Firebase
import FacebookCore
import FacebookLogin
import GoogleMaps
import GooglePlaces
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var signalType: String = ""
    var lat: Double = 0.0
    var lng: Double = 0.0
    var learnmode: Bool = false
    var locationManager = LocationManager.sharedInstance
    
    var doAfterLaunch: String = ""
    
    var launchedShortcutItem: UIApplicationShortcutItem?
    
    enum ShortcutIdentifier: String {
        case Share
        case Add
        
        init?(fullType: String) {
            guard let last = fullType.components(separatedBy: ".").last else { return nil }
            self.init(rawValue: last)
        }
        
        var type: String {
            return Bundle.main.bundleIdentifier! + ".\(self.rawValue)"
        }
    }
    
    var window: UIWindow?
    let gcmMessageIDKey = "gcm.message_id"
    
    static var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func languageWillChange(notification:NSNotification){
        let targetLang = notification.object as! String
        DataStore.shared.setLang(token: targetLang)
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        GMSServices.provideAPIKey("AIzaSyAI4xfwJSScsWs1cKBTJCcxIaLg8iuLyfM")
        GMSPlacesClient.provideAPIKey("AIzaSyAI4xfwJSScsWs1cKBTJCcxIaLg8iuLyfM")
        Messaging.messaging().delegate = self

        UNUserNotificationCenter.current().delegate = self
        
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: {_, _ in }
        )
    
        application.registerForRemoteNotifications()
        
        // lang
        
        _ = Theme.shared
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        // Override point for customization after application launch.
        var shouldPerformAdditionalDelegateHandling = true
        
        // If a shortcut was launched, display its information and take the appropriate action
        if let shortcutItem = launchOptions?[UIApplicationLaunchOptionsKey.shortcutItem] as? UIApplicationShortcutItem {
            launchedShortcutItem = shortcutItem
            // This will block "performActionForShortcutItem:completionHandler" from being called.
            shouldPerformAdditionalDelegateHandling = false
        }

        //Launched from push notification
        let remoteNotif = launchOptions?[UIApplicationLaunchOptionsKey.remoteNotification] as? NSDictionary
        if remoteNotif != nil {
            let identifier = remoteNotif!["indetifier" as NSString] as? String
            if identifier != nil {
                self.doAfterLaunch = identifier!
                print("got init param")
                print(self.doAfterLaunch)
            }
        } else {
            print("//////////////////////////Normal launch")
        }
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Splash", bundle: nil)
        UIApplication.shared.statusBarStyle = .lightContent
        let splashViewController = mainStoryboard.instantiateViewController(withIdentifier: "SplashViewController")
        self.window?.rootViewController = splashViewController
        self.window?.makeKeyAndVisible()
        
        locationManager.startUpdatingLocationWithCompletionHandler { (latitude, longitude, status, verboseMessage, error) -> () in
            if error != nil {
                print(error)
            } else {
                self.lat = latitude
                self.lng = longitude
                print("lat")
                print(latitude)
            }
        }
        
        Fabric.with([Crashlytics.self])
        NotificationCenter.default.addObserver(self, selector: #selector(storeUser), name: Constants.Notifications.ReloadListView, object: nil)
        
        DataStore.shared.fillUser()
        
        return shouldPerformAdditionalDelegateHandling
    
    }
    
    func storeUser() {
        DataStore.shared.syncUser()
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        let message = url.host?.removingPercentEncoding
        doAfterLaunch = message!
        sendSOS(type:message)

        /*
        let alertController = UIAlertController(title: "Incoming Message", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alertController.addAction(okAction)
        
        window?.rootViewController?.present(alertController, animated: true, completion: nil)
        */
        return true
    }
    
    
    
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        print("\n\nUser notification received\n")
        print(userInfo)
    }
   
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        let handledShortCutItem = handleShortCutItem(shortcutItem: shortcutItem)
        completionHandler(handledShortCutItem)
    }
    
    func applicationWillResignActive(_ application: UIApplication) {}
    func applicationDidEnterBackground(_ application: UIApplication) {}
    func applicationWillEnterForeground(_ application: UIApplication) {}
    func applicationDidBecomeActive(_ application: UIApplication) {
        guard let shortcut = launchedShortcutItem else { return }
        _ = handleShortCutItem(shortcutItem: shortcut)
        launchedShortcutItem = nil
    }
    func applicationWillTerminate(_ application: UIApplication) {
        locationManager.stopUpdatingLocation()
    }
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Unable to register for remote notifications: \(error.localizedDescription)")
    }
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("APNs token retrieved: \(deviceToken)")
    }
    
    func handleShortCutItem(shortcutItem: UIApplicationShortcutItem) -> Bool {
        var handled = false
        guard ShortcutIdentifier(fullType: shortcutItem.type) != nil else { return false }
        guard let shortCutType = shortcutItem.type as String? else { return false }
        
        switch (shortCutType) {
            case ShortcutIdentifier.Share.type:
                // Handle shortcut 1 (static).
                handled = true
                break
            case ShortcutIdentifier.Add.type:
                // Handle shortcut 2 (static).
                handled = true
                break
            default:
                break
        }
        
        // Construct an alert using the details of the shortcut used to open the application.
        //let alertController = UIAlertController(title: "Shortcut Handled", message: "\"\(shortcutItem.localizedTitle)\"", preferredStyle: .alert)
        //let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        //alertController.addAction(okAction)
        
        // Display an alert indicating the shortcut selected from the home screen.
        //window!.rootViewController?.present(alertController, animated: true, completion: nil)
        
        return handled
    }
    
    func sendCALL(number: String!, text: String!) {
        
    }
    
    func sendSMS(number: String!, text: String!) {
        
    }
    
    func sendMAIL(email: String!, text: String!) {
        
    }
    
    
    func sendSOS(type: String!) {
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "base", bundle: nil)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "BaseViewController")
        self.window?.rootViewController = vc
        self.window?.makeKeyAndVisible()
        
        if AppDelegate.shared.learnmode == true {
            let alert = UIAlertController(title: "Warning".localized, message: "You are in Learing mode, emergency signals are not sended out.".localized, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK".localized, style: .default, handler: { [weak alert] (_) in
            }))
            UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
            return
        }
        
        let bundleID = Bundle.main.bundleIdentifier!
        if bundleID.contains("pro") != true {
            let alert = UIAlertController(title: "Warning".localized, message: "This function is only works in Pro version".localized, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK".localized, style: .default, handler: { [weak alert] (_) in
            }))
            UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
            return
        }
        
        self.signalType = type
        
        StartDialog().show("") {_ in }
    }
    

    
    func Signal(type: String!) {
    
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "base", bundle: nil)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "BaseViewController")
        self.window?.rootViewController = vc
        self.window?.makeKeyAndVisible()
        vc.performSegue(withIdentifier: "medicalinfomodal", sender: nil)
        
        //var locationManager: CLLocationManager!
        
        //let lastlocation = locationManager.location
        
        var latitude:Double = 0
        var longitude:Double = 0
        
        //if(lastlocation != nil) {
            //latitude = (lastlocation?.coordinate.latitude)!
            //longitude = (lastlocation?.coordinate.longitude)!
        //}

        let user = DataStore.shared.userData
        
        var smstext = "smstext".localized
        smstext += "lat: \(latitude) \n long: \(longitude) \n\nhttp://maps.google.com/maps?q=\(latitude),\(longitude)"
        
        var calltext = "calltext".localized + "latitude. \(latitude) longitude. \(longitude)"
        
        if type == "police" {
            if user?.gpolicecall == true  {
                for g in (user?.guards)! {
                    if g.enabled && g.asGcall {
                        sendCALL(number:g.phone, text:calltext)
                    }
                }
            }
            if user?.gpolicesms == true {
                for g in (user?.guards)! {
                    if g.enabled && g.asGsms {
                        sendSMS(number:g.phone, text:smstext)
                    }
                }
            }
            
            if user?.gpoliceemail == true {
                for g in (user?.guards)! {
                    if g.enabled && g.asGemail {
                        sendMAIL(email:g.email, text:smstext);
                    }
                }
            }
            if user?.policecall == true {
                sendSOS(number: DataStore.shared.userData?.policenumber)
            }
        }
        
        if type == "fire" {
            if user?.gfirecall == true {
                for g in (user?.guards)! {
                    if g.enabled && g.asGcall {
                        sendCALL(number:g.phone, text:calltext);
                    }
                }
            }
            
            if user?.gfiresms == true {
                for g in (user?.guards)! {
                    if g.enabled && g.asGsms {
                        sendSMS(number:g.phone, text:smstext);
                    }
                }
            }
            
            if user?.gfireemail == true {
                for g in (user?.guards)! {
                    if g.enabled && g.asGemail {
                        sendMAIL(email:g.email, text:smstext);
                    }
                }
            }
            
            if user?.firecall == true {
                sendSOS(number: DataStore.shared.userData?.firenumber)
            }
        }
        
        if type == "ambulance" {

            if user?.gambcall == true {
                for g in (user?.guards)! {
                    if g.enabled && g.asGcall {
                        sendCALL(number:g.phone, text:calltext);
                    }
                }
            }
            if user?.gambsms == true {
                for g in (user?.guards)! {
                    if g.enabled && g.asGsms {
                        sendSMS(number:g.phone, text:smstext);
                    }
                }
            }
            
            if user?.gambemail == true {
                for g in (user?.guards)! {
                    if g.enabled && g.asGemail {
                        sendMAIL(email:g.email, text:smstext);
                    }
                }
            }
            
            if user?.ambcall == true {
                sendSOS(number: DataStore.shared.userData?.ambulancenumber)
            }
        }
        
        if type == "sos" {
            
             if user?.gsoscall == true {
                for g in (user?.guards)! {
                    if g.enabled && g.asGcall {
                        sendCALL(number:g.phone, text:calltext);
                    }
                }
             }
             
             if user?.gsossms == true {
                for g in (user?.guards)! {
                    if g.enabled && g.asGsms {
                        sendSMS(number:g.phone, text:smstext);
                    }
                }
             }
             
            if user?.gsosemail == true {
                for g in (user?.guards)! {
                    if g.enabled && g.asGemail {
                        sendMAIL(email:g.email, text:smstext);
                    }
                }
            }
             
            if user?.soscall == true {
               sendSOS(number: DataStore.shared.userData?.emnumber)
            }
        }
        
        if type == "ta" {
            sendSOS(number: DataStore.shared.userData?.terrornumber)
            
            if user?.gtacall == true {
                for g in (user?.guards)! {
                    if g.enabled && g.asGcall {
                        sendCALL(number:g.phone, text:calltext);
                    }
                }
            }
            
            if user?.gtasms == true {
                for g in (user?.guards)! {
                    if g.enabled && g.asGsms {
                        sendSMS(number:g.phone, text:smstext);
                    }
                }
            }
            
            if user?.gtaemail == true {
                for g in (user?.guards)! {
                    if g.enabled && g.asGemail {
                        sendMAIL(email:g.email, text:smstext);
                    }
                }
            }
            
            if user?.tacall == true {
                sendSOS(number: DataStore.shared.userData?.terrornumber)
            }
        }
        
    }
    
    func sendSOS(number: String!) {
        
        UIApplication.shared.open(URL(string:"tel://"+number)!);
        
    }
    
    
}

// [START ios_10_message_handling]
@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        let userInfo = notification.request.content.userInfo
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        // Print full message.
        print(userInfo)
        // Change this to your preferred presentation option
        completionHandler([])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        // Print full message.
        print(userInfo)
        completionHandler()
    }
    
}

// [END ios_10_message_handling]
extension AppDelegate : MessagingDelegate {
    // [START refresh_token]
    func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
    // [END refresh_token]
    // [START ios_10_data_message]
    // Receive data messages on iOS 10+ directly from FCM (bypassing APNs) when the app is in the foreground.
    // To enable direct data messages, you can set Messaging.messaging().shouldEstablishDirectChannel to true.
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print("Received data message: \(remoteMessage.appData)")
    }
    // [END ios_10_data_message]
}


