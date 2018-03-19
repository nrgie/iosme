import UIKit

class SettingsViewController: UITableViewController {

    var data: [Setting]? = []
    
    @IBAction func saveBtn(_ sender: Any) {
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "base", bundle: nil)
        let baseController = mainStoryboard.instantiateViewController(withIdentifier: "BaseViewController") as! BaseViewController
        UIApplication.shared.delegate?.window??.rootViewController = baseController
        
    }
    
    @IBAction func backBtn(_ sender: Any) {
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "base", bundle: nil)
        let baseController = mainStoryboard.instantiateViewController(withIdentifier: "BaseViewController") as! BaseViewController
        UIApplication.shared.delegate?.window??.rootViewController = baseController
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        self.clearsSelectionOnViewWillAppear = true
        
        /*
        let navbar : navbarView = navbarView(frame: CGRect.zero)
        self.view.addSubview(navbar)
        navbar.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)
        */
        
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
        
        self.tableView.estimatedRowHeight = 40
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.reloadData()
        
        adjustTop()
        
        /*
        RestClient.getRundays(accessToken: DataStore.shared.getAccessToken()!, complitionBlock: { (err: String?, days: [RunDay]?) in
            if days != nil {
                
                self.data = days?.reversed()
                self.tableView.estimatedRowHeight = 68
                self.tableView.rowHeight = UITableViewAutomaticDimension
                self.tableView.reloadData()
                
            }
        })
        */
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }
 
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> SettingCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingscell") as! SettingCell
        cell.setting = data?[indexPath.row]
        
        return cell
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
    }
    
    func adjustTop() {
        self.tableView.contentInset = UIEdgeInsetsMake(0,0,0,0)
        self.tableView.contentOffset = CGPoint(x: 0, y: 0)
    }
}
