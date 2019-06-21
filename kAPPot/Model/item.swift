//
//  item.swift
//  kAPPot
//
//  Created by YasserOsama on 6/15/19.
//  Copyright © 2019 macOS Mojave. All rights reserved.
//

class item: SparePart , Equatable {
    var quantity : Int = 1
    var carItem : String = ""
    var seller : String = ""
    
    class func createItem(spareName : String , img_url : String , price : Int , quantity : Int , carItem : String , seller : String) -> item {
        let temp = item()
        temp.setSpareName(name: spareName)
        temp.setSparePrice(price: price)
        temp.setImgUrl(url: img_url)
        temp.setQuantity(quantity: quantity)
        temp.setSeller(seller: seller)
        temp.setCarItem(carItem: carItem)
        return temp
    }
    func setCarItem(carItem : String)  {
        self.carItem = carItem
    }
    func getCarItem() -> String {
        return self.carItem
    }
    func setSeller(seller : String)  {
        self.seller = seller
    }
    func getSeller() -> String {
        return self.seller
    }
    func setQuantity(quantity : Int)  {
        self.quantity = quantity
    }
    func getQuantity() -> Int {
        return self.quantity
    }
    static func ==(lhs : item, rhs : item) -> Bool {
        return lhs.getName() == rhs.getName() && lhs.getPrice() == rhs.getPrice()  && lhs.getCarItem() == rhs.getCarItem() && lhs.getSeller() == rhs.getSeller()
    }
}
