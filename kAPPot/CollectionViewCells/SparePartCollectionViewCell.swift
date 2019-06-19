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
    @IBOutlet weak var Image: UIImageView!
    
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Price: UILabel!
    
    
    var delegate : sparePartCellDelegate?
    
    func setSparePart(sparepart : SparePart)
    {
        //sparePartImage = sparepart.getImgUrl()
        Name.text = sparepart.getName()
        Price.text = "\(sparepart.getPrice())"
    }
    @IBAction func addSpareToCart(_ sender: UIButton) {
        delegate?.addSpareToCart(sparePart: currentSparePart)
    }
}
