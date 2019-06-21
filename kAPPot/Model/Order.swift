//
//  Order.swift
//  kAPPot
//
//  Created by YasserOsama on 6/15/19.
//  Copyright © 2019 macOS Mojave. All rights reserved.
//

import FirebaseFirestore


class Order {
    var deliveryDate : Date!
    var deliveryStatus : Bool = false
    var address : String = ""
    func createOrder() {
        let today = Date()
        self.deliveryDate = Calendar.current.date(byAdding: .day, value: 1, to: today)!
        self.setItemsInCart {
            MapVC.convertLatLongToAddress(latitude: User.getUserLocation().latitude, longitude: User.getUserLocation().longitude, completion: { (res) in
                switch res
                {
                case .success(let userAddress):
                    self.address = userAddress
                    print("address in order \(self.address)")
                    Firestore.firestore().collection("Order").document("\(User.loggedInUser.getUserEmail())").setData([
                        "deliveryStatus" : self.deliveryStatus ,
                        "deliveryDate" : self.deliveryDate! ,
                        "address" : self.address
                        
                        ], merge: true)
                    
                    
                case .failure(let error):
                    print(error)
                }
            })
        }
        
        
        
    }
    func setItemsInCart(completion : @escaping () -> ())  {
    //    Firestore.firestore().collection("Order").document("\(User.loggedInUser.getUserEmail())").setData(["spares" : ""])
        User.loggedInUser.cart.items.forEach { (item) in
            print(item.getName())
            let spareDictionary = ["name" : item.getName() , "price" : item.getPrice() , "img_url" : item.getImgUrl() , "quantity" : item.getQuantity() , "seller" : item.getSeller() , "carItem" : item.getCarItem()] as [String : Any]
            print(spareDictionary)
            Firestore.firestore().collection("Order").document("\(User.loggedInUser.getUserEmail())").updateData([
                "spares": FieldValue.arrayUnion([spareDictionary])
                ])
            
        }
        completion()
    }
    
    
}
