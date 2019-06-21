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
    var orderItems = [item]()
    var totalPrice : Int = 0
    
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
                        "address" : self.address ,
                        "totalPrice" : self.totalPrice
                        
                        ], merge: true)
                    
                    
                case .failure(let error):
                    print(error)
                }
            })
        }
        
        
        
    }
    
    func getOrder(email : String , completion: @escaping (Result<Order,Error>) -> () )  {
        //var tempItems = [item]()
        let tempOrder = Order()
        Firestore.firestore().collection("Order").document("\(email)").getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data()
                tempOrder.address = dataDescription!["address"] as! String
                tempOrder.deliveryDate = dataDescription!["deliveryDate"] as? Date
                tempOrder.deliveryStatus = dataDescription!["deliveryStatus"] as! Bool
                tempOrder.totalPrice = dataDescription!["totalPrice"] as! Int
                //guard let orderComponents = dataDescription as? [String : Any] else { return }
                
                guard let sparesItems = dataDescription!["spares"] as? [[String : Any]] else { return }
                if(!sparesItems.isEmpty){
                    sparesItems.forEach({ (retrievedSpareItem) in
                        let spareItem = item.createItem(spareName: retrievedSpareItem["name"] as! String, img_url: retrievedSpareItem["img_url"] as! String, price: retrievedSpareItem["price"] as! Int, quantity: retrievedSpareItem["quantity"] as! Int, carItem: retrievedSpareItem["carItem"] as! String, seller: retrievedSpareItem["seller"] as! String)
                        tempOrder.orderItems.append(spareItem)
                    })
                }
                dump(tempOrder)
                completion(.success(tempOrder))
            }
            else {
                completion(.failure(error!))
            }
        }
    }
    
    func getOrderItems() -> [item] {
        return self.orderItems
    }
    func setTotalPrice(totalPrice : Int)  {
        self.totalPrice = totalPrice
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
