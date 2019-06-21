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
            let spareDictionary = ["name" : item.getName() , "price" : item.getPrice() , "img_url" : item.getImgUrl() , "quantity" : item.getQuantity() , "seller" : item.getSeller() , "carItem" : item.getCarItem()] as [String : Any]
            Firestore.firestore().collection("Cart").document("\(User.loggedInUser.getUserEmail())").updateData([
                "spares": FieldValue.arrayUnion([spareDictionary])
                ])
        }
        
    }
    func getCartItems(email : String , completion: @escaping (Result<[item],Error>) -> () )  {
        var temp = [item]()
        Firestore.firestore().collection("Cart").document("\(email)").getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data()
                guard let docData = dataDescription!["spares"] as? [[String : Any]] else { return }
                if(!docData.isEmpty){
                    docData.forEach({ (retrievedSpareItem) in
                        let spareItem = item.createItem(spareName: retrievedSpareItem["name"] as! String, img_url: retrievedSpareItem["img_url"] as! String, price: retrievedSpareItem["price"] as! Int, quantity: retrievedSpareItem["quantity"] as! Int, carItem: retrievedSpareItem["carItem"] as! String, seller: retrievedSpareItem["seller"] as! String)
                        temp.append(spareItem)
                    })
                }
                completion(.success(temp))
            }
            else {
                completion(.failure(error!))
            }
        }
    }
    func deleteCart()
    {
        Firestore.firestore().collection("Cart").document("\(User.loggedInUser.getUserEmail())").delete()
    }
    
}
