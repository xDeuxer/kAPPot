//
//  Cart.swift
//  kAPPot
//
//  Created by macOS Mojave on 6/7/19.
//  Copyright © 2019 macOS Mojave. All rights reserved.
//
import FirebaseFirestore

class Cart {
    
    var items = [item]()
    
    //private let dbRef = Firestore.firestore()
    func addToUserCart(sparePart : SparePart) {
       let spareItem = item(spareName : sparePart.getName() , img_url : sparePart.getImgUrl() , price : sparePart.getPrice())
        if(self.items.contains(spareItem)) { return }
        self.items.append(spareItem)
        dump(spareItem)
        self.deleteCart()
        Firestore.firestore().collection("Cart").document("\(User.loggedInUser.getUserEmail())").setData(["spares" : ""])
        items.forEach { (item) in
            let spareDictionary = ["name" : item.getName() , "price" : item.getPrice() , "img_url" : item.getImgUrl() , "quantity" : item.getQuantity()] as [String : Any]
            Firestore.firestore().collection("Cart").document("\(User.loggedInUser.getUserEmail())").updateData([
                "spares": FieldValue.arrayUnion([spareDictionary])
                ])
        }
        
    }
    func deleteCart()
    {
        Firestore.firestore().collection("Cart").document("\(User.loggedInUser.getUserEmail())").delete()
    }
    
}
