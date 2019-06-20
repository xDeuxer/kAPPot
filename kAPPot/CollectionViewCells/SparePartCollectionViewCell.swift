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
    
    var cellindex : Int = 5
    var currentSparePart = SparePart()
    @IBOutlet weak var Image: UIImageView!
    
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Price: UILabel!
    
    
    var delegate : sparePartCellDelegate?
    
    func setSparePart(sparepart : SparePart , cellindex : Int)
    {
        currentSparePart = sparepart
        let url = URL(string: sparepart.getImgUrl())
        let data = try? Data(contentsOf: url!)
        Image.image = UIImage(data: data!)
        Name.text = sparepart.getName()
        Price.text = "\(sparepart.getPrice()) EGP"
        self.cellindex = cellindex
    }
    @IBAction func addSpareToCart(_ sender: UIButton) {
        print(cellindex)
        delegate?.addSpareToCart(sparePart: currentSparePart)
    }
}
