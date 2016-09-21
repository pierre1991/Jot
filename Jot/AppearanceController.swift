//
//  AppearanceController.swift
//  Jot
//
//  Created by Pierre on 5/3/16.
//  Copyright © 2016 pierre. All rights reserved.
//

import Foundation
import UIKit

class AppearanceController {
    
    static func initializeAppearance() {
        UINavigationBar.appearance().barTintColor = .purpleNavigationBarColor()
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [
            NSForegroundColorAttributeName:UIColor.white,
            NSFontAttributeName: UIFont(name: "Avenir-Medium", size: 32)!
        ]
        UIApplication.shared.statusBarStyle = .lightContent
    }
}
