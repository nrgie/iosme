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
            
            Setting("pause", "learnmode".localized, "learnmodesub".localized, "studentmode"),
            Setting("gps", "tracking".localized, "trackingsub".localized, "studentmode"),
            Setting("flag", "currentcountry".localized, "currentcountrysub".localized, "studentmode"),
            
            Setting("", "detailsettings".localized, "", "separator"),
            
            Setting("male", "generalsettings".localized, "", "w1"),
            Setting("vcard", "sublabel_contact".localized, "", "w2"),
            Setting("list", "medilabel".localized, "", "w3"),
            Setting("peoples", "guardshandling".localized, "", "w4"),
            Setting("shield", "protectedstracking".localized, "", "w5"),
            Setting("alert", "signalsetup".localized, "", "w6"),

            Setting("", "informations".localized, "", "separator"),
            
            Setting("alert", "help".localized, "", "helppage"),
            Setting("alert", "applang".localized, "", "langpage"),
            Setting("alert", "terms".localized, "", "termspage"),
            Setting("alert", "appinvite".localized, "", "invitepage"),
            Setting("alert", "playdemosos".localized, "", "playsound"),
            Setting("alert", "exit".localized, "", "exit")
        
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
