//
//  car_storesModel.swift
//  kAPPot
//
//  Created by macOS Mojave on 6/5/19.
//  Copyright © 2019 macOS Mojave. All rights reserved.
//

import FirebaseFirestore



class car_storesModel: UIViewController{
    var dbRef = Firestore.firestore().collection("car_stores")
    var stores :String

    
    func getShopName(){
        let query = dbRef.order(by: "timestamp", descending: true).limit(to: 10)
        query.getDocuments { snapshot, error in
            print(error ?? "No error.")
            for doc in snapshot!.documents {
                let cat = Cat(snapshot: doc)
                self.cats.append(cat)
            }
            print(cats) // 1 what will this print now?
        }
    }
    
    /*
     var name :String = "EMPTY"
     
     
     let basicQuery = Firestore.firestore().collection("car_stores")
     basicQuery.addSnapshotListener { (snapshot, error) in
     if let error = error {
     print ("I got an error retrieving restaurants: \(error)")
     return
     }
     guard let snapshot = snapshot else { return }
     for storesDocument in snapshot.documents {
     if storesDocument.documentID=="Kia"{
     let arr = storesDocument.data()
     guard let address = arr["Shops"] as? [[String : Any]] else{ return }
     name = (address[1]["ShopName"]! as? String)!
     print("NAME INSIDE CLOSURE : \(name)")
     }
     }
     }
     }
     
     */
    
    
    
    /*
     func getLocation() -> String {
     return " "
     }
     
     
     func getRating() -> String {
     return " "
     }
     
     func getTelephone() -> String {
     " "
     }
     */
    
}



