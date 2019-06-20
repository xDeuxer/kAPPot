//
//  ShopCollectionViewCell.swift
//  kAPPot
//
//  Created by macOS Mojave on 5/8/19.
//  Copyright © 2019 macOS Mojave. All rights reserved.
//

import UIKit

protocol ShopCellDelegate {
    
    func getDirections(shop : Shop)
    
    func shopOnline(shop : Shop)
    
    func UpdateShop(shop : Shop)
    
    func DeleteShop(shop : Shop)
    
}

class ShopCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var shopImage: UIImageView!
    
    @IBOutlet weak var shopName: UILabel!
    
    @IBOutlet weak var shopNumber: UILabel!
    
    @IBOutlet weak var shopRating: UILabel!
    
    @IBOutlet weak var shopDistance: UILabel!
    
   
    @IBOutlet weak var DirectionsButton: UIButton!
    @IBOutlet weak var OnlineBu: UIButton!
    
    var selectedShop = Shop()
    
    var delegate : ShopCellDelegate?
    func setShop(shop : Shop)
    {
        selectedShop=shop
        
      //  shopImage.image = UIImage(named : "\(selectedShop.SupportedCar.getCarModel())")
        shopName.text=selectedShop.getShopName()
        
        let telephoneNumbers = selectedShop.getTelephoneNo()
        shopNumber.text = "\(telephoneNumbers)"
        
        let rating = selectedShop.getRating()
        shopRating.text="\(rating)"
        
    }
    
    @IBAction func getDirectionsButton(_ sender: Any) {
        delegate?.getDirections(shop : selectedShop)
    }
    
    @IBAction func shopOnlineButton(_ sender: Any) {
        delegate?.shopOnline(shop : selectedShop)
    }
    
    @IBAction func UpdateShop(_ sender: Any) {
        
    }
    
    @IBAction func DeleteShop(_ sender: Any) {
    }
}
