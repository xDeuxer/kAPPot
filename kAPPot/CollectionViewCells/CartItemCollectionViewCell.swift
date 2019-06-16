//
//  CartItemCollectionViewCell.swift
//  kAPPot
//
//  Created by YasserOsama on 6/14/19.
//  Copyright © 2019 macOS Mojave. All rights reserved.
//

import UIKit
protocol  CartItemCellDelegate {
    func UpdateCartPrice(price : Int )
    func Removeitem(sparePart : item)
}

class CartItemCollectionViewCell: UICollectionViewCell {
    
    var cartItem = item()
    var quantityOrdered : Int  = 1
    
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var productName: UILabel!
    
    @IBOutlet weak var productPrice: UILabel!
    
    @IBOutlet weak var productQuantity: UILabel!
    
    var delegate : CartItemCellDelegate?
    
    func setCartItem(spare :item)
    {
        cartItem = spare
        productImage.image = UIImage()
        productName.text = spare.getName()
        productPrice.text = "\(spare.getPrice())"
        productQuantity.text = "1"
        
    }
   
    @IBAction func UpdateQuantity(_ sender: UIButton) {
        if(sender.tag == 1)
        {
            quantityOrdered += 1
            delegate?.UpdateCartPrice(price: Int(cartItem.getPrice()))
            
        }else{
            if(quantityOrdered == 1)
            {
                return
            }
            quantityOrdered -= 1
            delegate?.UpdateCartPrice(price: Int(-cartItem.getPrice()))
        }
        productQuantity.text = "\(quantityOrdered)"
    }
}
