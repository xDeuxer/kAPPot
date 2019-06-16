//
//  customNavBar.swift
//  kAPPot
//
//  Created by YasserOsama on 6/14/19.
//  Copyright © 2019 macOS Mojave. All rights reserved.
//

import UIKit

extension UINavigationController {


    func customNavBar(){
        
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.tintColor = .black
        navigationBar.backIndicatorImage = #imageLiteral(resourceName: "backArrow")
        navigationBar.backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "backArrow")
    }
}
