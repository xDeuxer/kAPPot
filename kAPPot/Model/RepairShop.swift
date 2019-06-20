//
//  RepairShop.swift
//  kAPPot
//
//  Created by macOS Mojave on 6/7/19.
//  Copyright © 2019 macOS Mojave. All rights reserved.
//

import FirebaseFirestore
import CoreLocation

class RepairShop: Shop {
    private var failureType:[String] = []
    var selectedFailureType:String = ""
    
    override init() {
        
    }
    init(repairType : String)
    {
        selectedFailureType = repairType
    }
    
    func setSelectedFailureType(failureType:String) {
        self.selectedFailureType = failureType
    }
    
    func setFailureType(failureType:[String]) {
      self.failureType = failureType
    }
    
    func getFailureType() -> [String] {
      return self.failureType
    }
    
    override func getAllCarShops(carType : String,completion: @escaping (Result<[Shop], Error>) -> ()) {
        var temp : [RepairShop] = []
        let basicQuery = Firestore.firestore().collection("car_workshops")
        basicQuery.addSnapshotListener { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let cars = snapshot else { return }
            for car in cars.documents {
                if car.documentID=="\(carType)"{
                    let arr = car.data()
                    guard let carShops = arr["Shops"] as? [[String : Any]] else{ return }
                    carShops.forEach({ (shop) in
                        let retrievedShop = RepairShop.convertToRepairShop(JsonObject: shop)
                        let failureTypes = retrievedShop.getFailureType()
                        if(failureTypes.contains("\(self.selectedFailureType)"))
                        {
                            User.getUserLocation(completion: { (res) in
                                switch res
                                {
                                    
                                case .success(let userlocation):
                                    retrievedShop.setDistanceFromUser(userLocation: userlocation, shopLocation: CLLocationCoordinate2DMake(retrievedShop.getLocations()[0]["lat"]!, retrievedShop.getLocations()[0]["long"]!))
                                    temp.append(retrievedShop)
                                case .failure(let error):
                                    print(error)
                                }
                            })
                            
                            
                        }
                    })
                    
                }
            }
            completion(.success(temp))
        }
    }
    
     class func convertToRepairShop(JsonObject: [String : Any]) -> RepairShop {
        let temp = RepairShop()
        temp.ShopName = JsonObject["ShopName"] as! String
        temp.location = JsonObject["location"] as! [[String : Double]]
        temp.telephoneNo = JsonObject["telephoneNo"] as! [Int]
        temp.rating  = JsonObject["rating"] as! Double
        temp.failureType = JsonObject["failureType"] as! [String]
        return temp
    }


}

