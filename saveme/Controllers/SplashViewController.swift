import Foundation
import UIKit
import KYDrawerController
//import FacebookCore
import FacebookLogin
import AVKit
import AVFoundation
import MediaPlayer

class SplashViewController : UIViewController, AVPlayerViewControllerDelegate {
    
    @IBOutlet weak var modeLogo: UIImageView!
    @IBOutlet weak var videobtn: UIButton!
    @IBOutlet weak var terms: UILabel!
    @IBOutlet weak var fbbtn: UIButton!
    @IBOutlet weak var checkbox: UIButton!
    
    var acceptterms: Bool = false
    
    @IBAction func checking(_ sender: Any) {
        
        checkbox.setImage(UIImage(named: "checkboxChecked"), for: UIControlState())
        acceptterms = true
        
    }
    
    let controller = AVPlayerViewController()
    
    @IBAction func fblogin(_ sender: Any) {
        
        if(acceptterms) {
        
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions: [.publicProfile, .email], viewController: nil) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                print("Logged in!")
                
                DataStore.shared.setAccessToken(token: accessToken.authenticationToken)
                
                NotificationCenter.default.post(name: Constants.Notifications.UserLoggedInNotification, object: nil, userInfo: nil)
                
                DispatchQueue.main.async(){
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "base", bundle: nil)
                    let baseController = mainStoryboard.instantiateViewController(withIdentifier: "BaseViewController") as! BaseViewController
                    UIApplication.shared.delegate?.window??.rootViewController = baseController
                }
            }
            
        }
            
        }
        
    }
    
    @IBAction func playvideo(_ sender: Any) {
        
        let item = AVPlayerItem(url: URL(fileURLWithPath: "http://saveme-app.com/introvideo.mp4"))
        let player = AVPlayer(playerItem: item)
        
        controller.player = player
        
        /*
        self.addChildViewController(controller)
        self.view.addSubview(controller.view)
        controller.view.frame = self.view.frame
        */
        
        self.showDetailViewController(controller, sender: self)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.playerDidFinishPlaying(sender:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: item)
        player.play()
        
    }
    
    func endPlay(){
       controller.view.removeFromSuperview()
    }
    
    func playerDidFinishPlaying(sender: Notification) {
       controller.view.removeFromSuperview()
    }
    
    
    @IBAction func startup(_ sender: Any) {

        if(acceptterms) {
            self.showWizardScreen()
        }
        
    }
    
    @IBOutlet weak var loginbtn: UIButton!
    
    @IBAction func loginview(_ sender: Any) {
        self.showLoginScreen()
    }
    
    func userDidTapLabel(tapGestureRecognizer: UITapGestureRecognizer) {
        
        UIApplication.shared.open(NSURL(string:"http://www.saveme-app.com/terms.html")! as URL)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if DataStore.shared.getAccessToken() != nil {
            DataStore.shared.fillUser()
            return self.showMainScreen()
        }
        
        // Add a custom login button to your app
        //let myLoginButton = UIButton(type: .Custom)]
        //myLoginButton.backgroundColor = UIColor.darkGrayColor()
        //myLoginButton.frame = CGRect(0, 0, 180, 40);
        //myLoginButton.center = view.center
        //myLoginTitle.setTitle("My Login Button" forState: .Normal)
        
        let myLoginButton = LoginButton(readPermissions: [ .publicProfile ])
        myLoginButton.center = view.center
        
        terms.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(userDidTapLabel(tapGestureRecognizer:)))
        terms.addGestureRecognizer(tapGesture)
        
        //guard let number = URL(string:"tel://112") else { return; }
        //UIApplication.shared.open(number);
        //myLoginButton.addTarget(self, action: @selector(self.loginButtonClicked) forControlEvents: .TouchUpInside)
        //view.addSubview(myLoginButton)

    }

    func showWizardScreen(){
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "wizard1", bundle: nil)
        let settingsController = mainStoryboard.instantiateViewController(withIdentifier: "wizard1") as! Wizard1ViewController
        UIApplication.shared.delegate?.window??.rootViewController = settingsController
    }
    
    func showLoginScreen(){
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
        let loginController = mainStoryboard.instantiateViewController(withIdentifier: "SigninPageViewController") as! SigninPageViewController
        UIApplication.shared.delegate?.window??.rootViewController = loginController
    }

    
    func showMainScreen(){
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "base", bundle: nil)
        let baseController = mainStoryboard.instantiateViewController(withIdentifier: "BaseViewController") as! BaseViewController
        UIApplication.shared.delegate?.window??.rootViewController = baseController
    }
    
}
