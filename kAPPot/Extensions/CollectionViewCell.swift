//
//  CollectionViewCell.swift
//  kAPPot
//
//  Created by YasserOsama on 6/12/19.
//  Copyright © 2019 macOS Mojave. All rights reserved.
//

import UIKit

extension UICollectionViewCell {
    
    
    
    func setupCellappearance(){
        
        contentView.layer.cornerRadius = 4.0
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = false
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1.0)
        layer.shadowRadius = 4.0
        layer.shadowOpacity = 0.7
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
    }
    
}
