//
//  SparePartCollectionViewCell.swift
//  kAPPot
//
//  Created by YasserOsama on 6/12/19.
//  Copyright © 2019 macOS Mojave. All rights reserved.
//

import UIKit

protocol sparePartCellDelegate {
    func addSpareToCart(sparePart : SparePart)
}
class SparePartCollectionViewCell: UICollectionViewCell {
    
    var currentSparePart = SparePart()
    @IBOutlet weak var sparePartImage: UIImageView!
    
    @IBOutlet weak var sparePartDescirption: UILabel!
    @IBOutlet weak var sparePartPrice: UILabel!
    
    
    var delegate : sparePartCellDelegate?
    
    @IBAction func addSpareToCart(_ sender: UIButton) {
        delegate?.addSpareToCart(sparePart: currentSparePart)
    }
}
