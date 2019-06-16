//
//  item.swift
//  kAPPot
//
//  Created by YasserOsama on 6/15/19.
//  Copyright © 2019 macOS Mojave. All rights reserved.
//

class item: SparePart {
    var quantity : Int = 1
    class func createItem(spareName : String , img_url : String , price : Int , quantity : Int) -> item {
        let temp = item()
        temp.setSpareName(name: spareName)
        temp.setSparePrice(price: price)
        temp.setImgUrl(url: img_url)
        temp.setQuantity(quantity: quantity)
        return temp
    }
    func setQuantity(quantity : Int)  {
        self.quantity = quantity
    }
    func getQuantity() -> Int {
        return self.quantity
    }
}
