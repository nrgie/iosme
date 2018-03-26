import UIKit

class QuickSettingsViewController: UIViewController {

    var data: [Setting]? = []
    
    
    @IBAction func done(_ sender: Any) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "base", bundle: nil)
        let baseController = mainStoryboard.instantiateViewController(withIdentifier: "BaseViewController") as! BaseViewController
        UIApplication.shared.delegate?.window??.rootViewController = baseController
    }
    
    @IBAction func cancel(_ sender: Any) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "base", bundle: nil)
        let baseController = mainStoryboard.instantiateViewController(withIdentifier: "BaseViewController") as! BaseViewController
        UIApplication.shared.delegate?.window??.rootViewController = baseController
    }
    
    @IBOutlet weak var listview: RollView!
    
    func reload() {
        listview.reload()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        data = [
            
            Setting("", "quicksettings".localized, "", "separator"),
            
            Setting("ic_pause_circle_outline_black_24dp", "learnmode".localized, "learnmodesub".localized, "learn"),
            Setting("ic_gps_fixed_black_24dp", "tracking".localized, "trackingsub".localized, "tracking"),
            Setting("ic_flag_black_24dp", "currentcountry".localized, "currentcountrysub".localized, "w4"),
            
            Setting("", "detailsettings".localized, "", "separator"),
            
            Setting("ic_verified_user_black_24dp", "generalsettings".localized, "", "w1"),
            Setting("ic_contact_mail_black_24dp", "sublabel_contact".localized, "", "w2"),
            Setting("ic_library_books_black_24dp", "medilabel".localized, "", "w3"),
            Setting("ic_supervisor_account_black_24dp", "guardshandling".localized, "", "w5"),
            Setting("ic_warning_black_24dp", "signalsetup".localized, "", "w6"),

            Setting("", "informations".localized, "", "separator"),
            
            Setting("ic_help_black_24dp", "help".localized, "", "helppage"),
            Setting("ic_flag_black_24dp", "applang".localized, "", "langpage"),
            Setting("ic_bookmark_border_black_24dp", "terms".localized, "", "termspage"),
            //Setting("ic_send_black_24dp", "appinvite".localized, "", "invitepage"),
            Setting("ic_speaker_phone_black_24dp", "playdemosos".localized, "", "playsound"),
            Setting("ic_exit_to_app_black_24dp", "exit".localized, "", "exit")
        
        ]
        
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Constants.Notifications.ReloadListView, object: nil)
        listview.autoresizingMask = [ .flexibleWidth, .flexibleHeight ]
        let adapter = QuickSettingsListAdapter()
        adapter.items = data
        
        listview.adapter = adapter
        listview.reload()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
 
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
    }

}
