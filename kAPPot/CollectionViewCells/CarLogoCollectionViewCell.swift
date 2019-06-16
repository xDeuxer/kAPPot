//
//  CollectionViewCell.swift
//  kAPPot
//
//  Created by macOS Mojave on 4/28/19.
//  Copyright © 2019 macOS Mojave. All rights reserved.
//

import UIKit

protocol carCellDelegate {
    func LogoTapped(name : String)
}

class CarLogoCollectionViewCell: UICollectionViewCell {
    
    var logoName : String!
    
    func setCellLogoName(logoname : String){
        logoName=logoname
    }
  
    var delegate : carCellDelegate?
    
    @IBOutlet weak var carLogo: UIImageView!
    
    @IBAction func CarChosen(_ sender: Any) {
        
        delegate?.LogoTapped(name : logoName)
    }
}
