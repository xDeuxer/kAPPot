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
    func updateUserCart() {
       
        self.deleteCart()
        Firestore.firestore().collection("Cart").document("\(User.loggedInUser.getUserEmail())").setData(["spares" : ""])
        items.forEach { (item) in
            print(item.getName())
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
