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
    
    var lat: Double = 0.0
    var lng: Double = 0.0
    
    var locationManager = LocationManager.sharedInstance
    
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
    
    /// Saved shortcut item used as a result of an app launch, used later when app is activated.
    var launchedShortcutItem: UIApplicationShortcutItem?
    
    func handleShortCutItem(shortcutItem: UIApplicationShortcutItem) -> Bool {
        var handled = false
        
        // Verify that the provided `shortcutItem`'s `type` is one handled by the application.
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
        let alertController = UIAlertController(title: "Shortcut Handled", message: "\"\(shortcutItem.localizedTitle)\"", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        // Display an alert indicating the shortcut selected from the home screen.
        window!.rootViewController?.present(alertController, animated: true, completion: nil)
        
        return handled
    }
    
    var window: UIWindow?
    let gcmMessageIDKey = "gcm.message_id"
    
    
    static var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
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
        
        
        /**
        let linkAction = UIMutableUserNotificationAction()
        linkAction.identifier = "showrun"
        linkAction.title = "Megnézem"
        linkAction.activationMode = UIUserNotificationActivationMode.foreground
        linkAction.isDestructive = false
        
        let linkCategory = UIMutableUserNotificationCategory()
        linkCategory.identifier = "linkCateg"
        linkCategory.setActions([linkAction], for: UIUserNotificationActionContext.default)
        linkCategory.setActions([linkAction], for: UIUserNotificationActionContext.minimal)
        */
        
        /*
        application.registerUserNotificationSettings(UIUserNotificationSettings(types: [.alert , .badge , .sound], categories: Set(arrayLiteral: linkCategory)))
        */
        
        Fabric.with([Crashlytics.self])
        
        
        
        return shouldPerformAdditionalDelegateHandling
        
    }
    
    
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        
        print("\n\nUser notification received\n")
        
        // re-fetch programs and init notification again for next day to prevent un-opened app.
        
        if DataStore.shared.getAccessToken() != nil {
            RestClient.getUser(accessToken: DataStore.shared.getAccessToken()! , complitionBlock: { (error: String?, userResponse: UserResponse?) in
                if error == nil && userResponse!.userId != nil {
                    RestClient.getUserData(userId: userResponse!.userId, accessToken: DataStore.shared.getAccessToken()!, complitionBlock: { (error: String?, userDataResponse: UserDataResponse?) in
                        if error == nil {
                            DataStore.shared.userData = userDataResponse?.userData.first
                            DataStore.shared.subscriptions = userDataResponse?.userSubscriptions
                            RestClient.getPrograms(accessToken: DataStore.shared.getAccessToken()!, complitionBlock: { (err: String?, programs: [Program]?) in
                                if programs != nil {
                                    DataStore.shared.programs = programs
                                }
                            })
                        }
                        
                    })
                }
            })
        }
        
    }
    
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
       
        print("\n\nUser notification received\n")
        
        print(userInfo)
        
        // re-fetch programs and init notification again for next day to prevent un-opened app.
        /*
        if DataStore.shared.getAccessToken() != nil {
            RestClient.getUser(accessToken: DataStore.shared.getAccessToken()! , complitionBlock: { (error: String?, userResponse: UserResponse?) in
                if error == nil && userResponse!.userId != nil {
                    RestClient.getUserData(userId: userResponse!.userId, accessToken: DataStore.shared.getAccessToken()!, complitionBlock: { (error: String?, userDataResponse: UserDataResponse?) in
                        if error == nil {
                            DataStore.shared.userData = userDataResponse?.userData.first
                            DataStore.shared.subscriptions = userDataResponse?.userSubscriptions
                            RestClient.getPrograms(accessToken: DataStore.shared.getAccessToken()!, complitionBlock: { (err: String?, programs: [Program]?) in
                                    if programs != nil {
                                        DataStore.shared.programs = programs
                                    }
                            })
                        }
                    
                   })
               }
            })
        }
         */
        
    }
   
    
    func application(_ application: UIApplication, handleActionWithIdentifier identifier: String?, for notification: UILocalNotification, completionHandler: @escaping () -> Void) {
        
        print(identifier!)
        print(notification.category!)
        
        // Point for handling the local notification Action. Provided alongside creating the notification.
        if identifier == "showrun" {
            print(notification.userInfo!["url"]!)
            UIApplication.shared.openURL(URL(string: notification.userInfo!["url"]! as! String)!)
        }
        
        completionHandler()
        
    }
    
    /*
      func registerForLocalNotification(day: Int, runday: Int, url1: String, url2: String) {
        
        print(day)
        print(runday)
        print(url1)
        print(url2)
        
        
        UIApplication.shared.scheduledLocalNotifications?.forEach({ (localNotification: UILocalNotification) in
            print("\n\nCancel notification for: \(localNotification.fireDate)")
            UIApplication.shared.cancelLocalNotification(localNotification)
        })
        
        if day > 0 && day < 43 {
            let notification = UILocalNotification()
            notification.fireDate = self.tomorrowMorning()
            print("Registered day for \(notification.fireDate)")
            notification.alertBody = "\(day). napi programod megérkezett!"
            notification.alertAction = "ok"
            notification.userInfo = ["day": day, "runday": 0, "url": ""]
            notification.soundName = UILocalNotificationDefaultSoundName
            UIApplication.shared.scheduleLocalNotification(notification)
        }
        
        if runday > 0 && runday < 43 {
            
            if url1 != "" {
                let notification = UILocalNotification()
                notification.fireDate = self.tomorrowMorning()
                print("Registered run1 for \(notification.fireDate)")
                if url2 != "" {
                    notification.alertBody = "\(runday). napi 5km programod megérkezett!"
                } else {
                    notification.alertBody = "\(runday). napi futás programod megérkezett!"
                }
                
                notification.alertAction = "showday"
                notification.category = "linkCateg"
                notification.userInfo = ["day": day, "runday": runday, "url":url1]
                notification.soundName = UILocalNotificationDefaultSoundName
                UIApplication.shared.scheduleLocalNotification(notification)
            }
            
            if url2 != "" {
                let notification = UILocalNotification()
                notification.fireDate = self.tomorrowMorning()
                print("Registered run2 for \(notification.fireDate)")
                notification.alertBody = "\(runday). napi 10 km programod megérkezett!"
                notification.alertAction = "showday"
                notification.category = "linkCateg"
                notification.userInfo = ["day": day, "runday": runday, "url":url2]
                notification.soundName = UILocalNotificationDefaultSoundName
                UIApplication.shared.scheduleLocalNotification(notification)
            }
        }
    }
 */
    /*
    private func tomorrowMorning() -> Date? {
        let now = Date()
        var tomorrowComponents = DateComponents()
        tomorrowComponents.day = 1
        let calendar = Calendar.current
        if let tomorrow = calendar.date(byAdding: tomorrowComponents, to: now) {
            let components: Set<Calendar.Component> = [.era, .year, .month, .day, .hour, .minute]
            var tomorrowValidTime = calendar.dateComponents(components, from: tomorrow)
            tomorrowValidTime.hour = 9
            tomorrowValidTime.minute = 41
            if let tomorrowMorning = calendar.date(from: tomorrowValidTime)  {
                return tomorrowMorning
            }
            
        }
        return nil
    }
    
    private func nowplusthreemin() -> Date? {
        let now = Date()
        var tomorrowComponents = DateComponents()
        tomorrowComponents.minute = 2
        let calendar = Calendar.current
        if let tomorrow = calendar.date(byAdding: tomorrowComponents, to: now) {
            let components: Set<Calendar.Component> = [.era, .year, .month, .day, .hour, .minute]
            let tomorrowValidTime = calendar.dateComponents(components, from: tomorrow)
            //tomorrowValidTime.hour = 9
            //tomorrowValidTime.minute = 41
            if let tomorrowMorning = calendar.date(from: tomorrowValidTime)  {
                return tomorrowMorning
            }
            
        }
        return nil
    }*/
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        let handledShortCutItem = handleShortCutItem(shortcutItem: shortcutItem)
        completionHandler(handledShortCutItem)
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        guard let shortcut = launchedShortcutItem else { return }
        _ = handleShortCutItem(shortcutItem: shortcut)
        launchedShortcutItem = nil
        
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        locationManager.stopUpdatingLocation()
    }
    

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Unable to register for remote notifications: \(error.localizedDescription)")
    }
    // This function is added here only for debugging purposes, and can be removed if swizzling is enabled.
    // If swizzling is disabled then this function must be implemented so that the APNs token can be paired to
    // the FCM registration token.
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("APNs token retrieved: \(deviceToken)")
        // With swizzling disabled you must set the APNs token here.
        // Messaging.messaging().apnsToken = deviceToken
    }
    
}

// [START ios_10_message_handling]
@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
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
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
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


