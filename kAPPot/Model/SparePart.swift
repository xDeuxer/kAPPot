//
//  SparePart.swift
//  kAPPot
//
//  Created by macOS Mojave on 6/7/19.
//  Copyright © 2019 macOS Mojave. All rights reserved.
//

import FirebaseFirestore

class SparePart {
    var spareName : String = ""
    var img_url : String = ""
    var price : Int = 0
    
    
    init() {
        
    }
    init(spareName : String , img_url : String , price : Int) {
        self.price = price
        self.spareName = spareName
        self.img_url = img_url
    }
    func setSpareName(name : String)
    {
        self.spareName = name
    }
    func setSparePrice(price : Int)
    {
        self.price=price
    }
    
    func setImgUrl(url : String)  {
        self.img_url = url
    }
    
    func getName()->String{
        return self.spareName
    }
    
    func getPrice()->Int{
        return self.price
    }
    func getImgUrl() -> String {
        return self.img_url
    }
    class func convertToSparePart(JsonSpare : [String : Any]) -> SparePart {
        let sparePart = SparePart()
        sparePart.spareName = JsonSpare["name"] as! String
        sparePart.img_url = JsonSpare["img_url"] as! String
        sparePart.price = JsonSpare["price"] as! Int
        return sparePart
    }
    
}
