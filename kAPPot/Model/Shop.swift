//
//  car_storesModel.swift
//  kAPPot
//
//  Created by macOS Mojave on 6/5/19.
//  Copyright © 2019 macOS Mojave. All rights reserved.
//

import FirebaseFirestore

import CoreLocation
import MapKit

class Shop{
    
    var ShopName:String = ""
    var rating:Double = 0.0
    var location:[[String : Double]] = []
    var telephoneNo:[Int] = []
    var distance : Double = 0.0
    
    
    
    
    func setShopName(shopname:String) {
        self.ShopName = shopname
    }
    
    func setRating(rating:Double) {
        self.rating = rating
    }
    
    func setLocations(location:[[String : Double]]) {
        self.location = location
    }
    
    func setTelephoneNo(telephoneNo:[Int]) {
        self.telephoneNo=telephoneNo
    }
    
    
    func getShopName() -> String {
        return self.ShopName
    }
    
    func getRating() -> Double {
        return self.rating
    }
    
    func getLocations() -> [[String : Double]] {
        return location
    }
    
    func getTelephoneNo() -> [Int] {
        return self.telephoneNo
        
    }
    
    
    func getAllCarShops(carType : String , completion: @escaping (Result<[Shop],Error>) -> ())
    {
        var temp : [Shop] = []
        let basicQuery = Firestore.firestore().collection("car_stores")
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
              
                       let retrievedShop = Shop.convertToShop(JsonObject: shop)
                        retrievedShop.setDistanceFromUser(userLocation: User.getUserLocation(), shopLocation: CLLocationCoordinate2DMake(retrievedShop.getLocations()[0]["lat"]!, retrievedShop.getLocations()[0]["long"]!))
                        temp.append(retrievedShop)
                        
                    })
                }
            }
           // print(temp)
            completion(.success(temp))
        }
    
    }

    class func convertToShop(JsonObject : [String : Any]) -> Shop
    {
        let temp = Shop()
        temp.ShopName = JsonObject["ShopName"] as! String
        temp.location = JsonObject["location"] as! [[String : Double]]
        temp.telephoneNo = JsonObject["telephoneNo"] as! [Int]
        temp.rating  = JsonObject["rating"] as! Double
        return temp
    }
    
    func setDistanceFromUser(userLocation: CLLocationCoordinate2D ,shopLocation: CLLocationCoordinate2D){
        let distanceFromUser = CLLocation.distance(from: userLocation, to: shopLocation)
        
        self.distance = (distanceFromUser / 1000).rounded()
        
        
        
    }
    class func sortByDistance(shops: [Shop])  -> [Shop] {
        
        //let sortedShopDistance = shopDistances.sorted(by: { $0 < $1 })
        let sortedShops = shops.sorted(by: { $0.distance < $1.distance })
        //print(sortedShopDistance)
        return sortedShops
    }
    
    
    
    
}


/*
 func getDistance(userLocation: CLLocation , shopLocation: CLLocation) -> Double {
 let Distance = userLocation.distance(from: shopLocation)
 return Distance / 1000
 }
 
 func sortByDistance(Distance: [String : Double])  {
 Distance.sorted(by: < )
 }
 
 func getSortedDistance(shopsSortedDistances: [String : Double] , key: String) -> Double {
 let currentDistance = shopsSortedDistances["key"] ?? 40
 return currentDistance
 }
 */
