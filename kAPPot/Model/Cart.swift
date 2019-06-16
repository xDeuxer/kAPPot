//
//  Cart.swift
//  kAPPot
//
//  Created by macOS Mojave on 6/7/19.
//  Copyright © 2019 macOS Mojave. All rights reserved.
//
import FirebaseFirestore

class Cart {
    
    var userid : String = "any id"
    var items = [item]()
    
    //private let dbRef = Firestore.firestore()
    func addToUserCart() {
        let item1 = item.createItem(spareName: "item1", img_url: "url1", price: 22, quantity: 11)
        let item2 = item.createItem(spareName: "item2", img_url: "url2", price: 23, quantity: 4)
        let item3 = item.createItem(spareName: "item3", img_url: "url3", price: 22, quantity: 1)
        items.append(item1)
        items.append(item2)
        items.append(item3)
        self.deleteCart()
        Firestore.firestore().collection("Cart").document("\(self.userid)").setData(["spares" : ""])
        items.forEach { (item) in
            let spareDictionary = ["name" : item.getName() , "price" : item.getPrice() , "img_url" : item.getImgUrl() , "quantity" : item.getQuantity()] as [String : Any]
            Firestore.firestore().collection("Cart").document("\(self.userid)").updateData([
                "spares": FieldValue.arrayUnion([spareDictionary])
                ])
        }
        
    }
    func deleteCart()
    {
        Firestore.firestore().collection("Cart").document("\(self.userid)").delete()
    }
    
}
