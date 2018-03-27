
import Foundation


struct Constants {
    
    struct EndPoints {
        
        static let Api: String = "http://api.saveme-app.com"
        static let WPApi: String = ""
        static let OAuthApi: String = ""
        static let clientId: String = ""
        static let clientSecret: String = ""
   
    }
    
    struct DataKeys {
        static let AccessTokenKey: String = "ELETMODVALTOK_ACCES_TOKEN"
        static let UserIdKey: String = "ELETMODVALTOK_USER_ID"
    }
    
    struct Cells {
        static let MenuItemCell: String = "MenuItemCell"
    }
    
    struct Notifications {
        
        static let SaveSpoken = NSNotification.Name(rawValue: "SaveSpoken")
        static let SaveAllergies = NSNotification.Name(rawValue: "SaveAllergies")
        
        static let CloseDialog = NSNotification.Name(rawValue: "CloseDialog")
        static let ReloadListView = NSNotification.Name(rawValue: "RefreshListView")
        static let ToggleMenuNotification = NSNotification.Name(rawValue: "ToggleMenuNotification")
        static let ShowInfoNotification = NSNotification.Name(rawValue: "ShowInfoNotification")
        static let GoBackNotification = NSNotification.Name(rawValue: "GoBackNotification")
        static let AnswerSelectedNotification = NSNotification.Name(rawValue: "AnswerSelectedNotification")
        static let UserLoggedInNotification = NSNotification.Name(rawValue: "UserLoggedInNotification")
        static let UserRegistrationNotification = NSNotification.Name(rawValue: "UserRegistrationNotification")
        static let UserLoggedOutNotification = NSNotification.Name(rawValue: "UserLoggedOutNotification")
        static let ProgramUpdatedNotification = NSNotification.Name(rawValue: "ProgramUpdatedNotification")
        static let ShowLoginNotification = NSNotification.Name(rawValue: "ShowLoginNotification")
        static let ShowRegistrationNotification = NSNotification.Name(rawValue: "ShowRegistrationNotification")
        static let ShowDailyProgramNotification = NSNotification.Name(rawValue: "ShowDailyProgramNotification")
    }
    
    struct MenuItemType {
        static let ShowWebContent: String = "ShowWebContent"
        static let ShowLogin: String = "ShowLogin"
        static let ShowRegistration: String = "ShowRegistration"
        static let ShowWhatIsThat: String = "ShowWhatIsThat"
        static let ShowDailyProgram: String = "ShowDailyProgram"
        static let ShowCalculators: String = "ShowCalculators"
        static let ShowMentors: String = "ShowMentors"
        static let ShowFaq: String = "ShowFaq"
        static let ShowRun: String = "ShowRun"
        static let ShowFacebookGroup: String = "ShowFacebookGroup"
        static let ShowProfile: String = "ShowProfile"
        static let ShowProfileEdit: String = "ShowProfileEdit"
        static let ShowMyDailyProgram: String = "ShowMyDailyProgram"
        static let ShowPrograms: String = "ShowPrograms"
        static let ShowFavourites: String = "ShowFavourites"
        static let Logout: String = "Logout"
    }
}
