//
//  RoundedButton.swift
//  kAPPot
//
//  Created by macOS Mojave on 4/26/19.
//  Copyright © 2019 macOS Mojave. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        updateCornerRadius()
    }
    
    @IBInspectable var rounded: Bool = false {
        didSet {
            updateCornerRadius()
        }
    }
    
    func updateCornerRadius() {
        layer.cornerRadius = rounded ? frame.size.height / 2 : 0
    }
    

}

