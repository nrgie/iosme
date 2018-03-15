//
//  AppNC.swift
//  saveme
//
//  Created by Tibi on 2018. 02. 28..
//  Copyright © 2018. Blueobject. All rights reserved.
//

import Foundation
import UIKit

class AppNavController: UINavigationController, HalfModalPresentable {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return isHalfModalMaximized() ? .default : .lightContent
    }
}
