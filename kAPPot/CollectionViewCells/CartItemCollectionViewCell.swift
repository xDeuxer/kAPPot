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
    
    var cellindex : Int = 5 // default value
    var cartItem = item()
    var quantityOrdered : Int  = 1
    
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var productName: UILabel!
    
    @IBOutlet weak var productPrice: UILabel!
    
    @IBOutlet weak var productQuantity: UILabel!
    
    var delegate : CartItemCellDelegate?
    
    func setCartItem(spare :item , cellindex : Int)
    {
        self.cellindex = cellindex
        cartItem = spare
        let url = URL(string: spare.getImgUrl())
        let data = try? Data(contentsOf: url!)
        productImage.image = UIImage(data: data!)
        
        productName.text = spare.getName()
        productPrice.text = "\(spare.getPrice())"
        productQuantity.text = "1"
        
    }
   
    @IBAction func UpdateQuantity(_ sender: UIButton) {
       // print("quanity increased")

        if(sender.tag == 1)
        {
            print("quanity increased")
            quantityOrdered += 1
            delegate?.UpdateCartPrice(price: Int(cartItem.getPrice()))
            
        }else{
            if(quantityOrdered == 1)
            {
                
                return
            }
            print("quanity decreased")

            quantityOrdered -= 1
            
            delegate?.UpdateCartPrice(price: Int(-cartItem.getPrice()))
        }
        print(quantityOrdered)
        productQuantity.text = "\(quantityOrdered)"
    }
}
