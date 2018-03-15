import Foundation
import UIKit
import RxSwift
import RxCocoa

class LoginPageViewController : UIViewController {
    
    @IBOutlet weak var emailField: FATextField!
    @IBOutlet weak var passwordField: FATextField!
    @IBOutlet weak var loginButton: CustomButton!
    let disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        self.emailField.registerForDismiss()
        self.passwordField.registerForDismiss()
        let emailValid: Observable<Bool> = self.emailField.rx.text.map { text in
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            return ((text?.characters.count)! > 0 && NSPredicate(format:"SELF MATCHES %@", emailRegEx).evaluate(with: text))
            }.shareReplay(1)
        let passwordValid: Observable<Bool> = self.passwordField.rx.text.map { text in
            return (text?.characters.count)! > 0
            }.shareReplay(1)
        let everythingValid: Observable<Bool>
            = Observable.combineLatest(emailValid, passwordValid) { $0 && $1 }
        everythingValid.bindTo(self.loginButton.rx.isEnabled).addDisposableTo(self.disposeBag)
    }
    
    @IBAction func loginUser(_ sender: Any) {
        self.view.endEditing(true)
        /*
        RestClient.loginCall(params: ["client_id": Constants.EndPoints.clientId, "grant_type": "password", "client_secret": Constants.EndPoints.clientSecret, "email": self.emailField.text ?? "", "password": self.passwordField.text ?? "" ]) { (error: String?, result: OAuthResponse?) in
            if (error == nil) {
                DataStore.shared.setAccessToken(token: result!.accessToken)
                RestClient.getUser(accessToken: result!.accessToken, complitionBlock: { (error: String?, userResponse: UserResponse?) in
                    if error == nil && userResponse!.userId != nil {
                        RestClient.getUserData(userId: userResponse!.userId, accessToken: DataStore.shared.getAccessToken()!, complitionBlock: { (error: String?, userDataResponse: UserDataResponse?) in
                            if error == nil {
                                RestClient.getPrograms(accessToken: DataStore.shared.getAccessToken()!, complitionBlock: { (err: String?, programs: [Program]?) in
                                    if programs != nil {
                                        DataStore.shared.programs = programs
                                        NotificationCenter.default.post(name: Constants.Notifications.ProgramUpdatedNotification, object: nil)
                                        
                                        DataStore.shared.userData = userDataResponse?.userData.first
                                        DataStore.shared.subscriptions = userDataResponse?.userSubscriptions
                                        NotificationCenter.default.post(name: Constants.Notifications.UserLoggedInNotification, object: nil, userInfo: nil)
                                    } else {
                                        MessageUtils.show(message: error!, with: "Error".localized, on: self)
                                    }
                                    
                                })
                            } else {
                                MessageUtils.show(message: error!, with: "Error".localized, on: self)
                            }
                        })
                        DataStore.shared.setUserId(userId: userResponse!.userId)
                    } else {
                        MessageUtils.show(message: error!, with: "Error".localized, on: self)
                    }
                })
            } else {
                MessageUtils.show(message: error!, with: "Error".localized, on: self)
            }
        }
        */
    }
    
    @IBAction func showInfo(_ sender: Any) {
        NotificationCenter.default.post(name: Constants.Notifications.ShowInfoNotification, object: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}
