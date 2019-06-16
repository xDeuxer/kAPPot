//
//  customButton.swift
//  kAPPot
//
//  Created by YasserOsama on 6/11/19.
//  Copyright © 2019 macOS Mojave. All rights reserved.
//

import UIKit

class customButton: UIButton {

    override func didMoveToWindow() {
       // self.backgroundColor=UIColor.lightGray
        self.layer.cornerRadius = self.frame.height/2
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity=0.5
        //self.setTitleColor(UIColor.black , for: .normal)
        
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
