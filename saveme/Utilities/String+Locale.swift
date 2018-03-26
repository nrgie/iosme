//
//  String+Locale.swift
//
//  Created by Gábor Eszenyi on 09/12/16.
//  Copyright © 2016 CodeYard. All rights reserved.
//

import Foundation
import UIKit


extension String {
    public func localizedWithComment(comment:String) -> String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: comment)
    }
    
    public var localized: String {
        
        var lang = DataStore.shared.getLang()
        if lang == "" {
            lang = "en"
        }
        
        if let path = Bundle.main.path(forResource: lang, ofType: "lproj") {
            if let bundle = Bundle(path: path) {
                return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
            }
        }
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
    public func localizeWithFormat(args: CVarArg...) -> String {
        return String(format: self.localized, locale: nil, arguments: args)
    }
    
    public func localizeWithFormat(local:NSLocale?, args: CVarArg...) -> String {
        return String(format: self.localized, locale: local as Locale?, arguments: args)
    }
}
