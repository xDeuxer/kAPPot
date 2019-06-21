//
//  User.swift
//  kAPPot
//
//  Created by macOS Mojave on 6/7/19.
//  Copyright © 2019 macOS Mojave. All rights reserved.
//

import FirebaseFirestore
import CoreLocation


class User: NSObject , CLLocationManagerDelegate{
    
    static var loggedInUser = User()
    //user attributes in db
    var name : String = ""
    var email : String = ""
    var password : String = ""
    var car = Car()
    var cart = Cart()
    var order = Order()
    
    override init() {
        
    }
    init(name : String , email : String , password : String)
    {
        self.name = name
        self.email = email
        self.password = password
    }
    
    func signup() -> Bool
    {
        var bool = true
        Firestore.firestore().collection("User").document("\(self.email)").setData([
            "name" : "\(self.name)",
            "email" : "\(self.email)",
            "password" : "\(self.password)",
            "car" : ""
        ]) { err in
            if let err = err {
                bool = false
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        return bool
    }
    
    class func signin(email : String,completion: @escaping (Result<User,Error>) -> ())
    {
        var user = User()
        Firestore.firestore().collection("User").document("\(email)").getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data()
                guard let docData = dataDescription as? [String : String] else { return }
                user = User(name: docData["name"]!, email: email, password: docData["password"]!)
                user.car.setCarModel(carModel: docData["car"]!)
                DispatchQueue.main.async {
                    Firestore.firestore().collection("Cart").document("\(email)").getDocument { (document, error) in
                        if let document = document, document.exists {
                            let dataDescription = document.data()
                            guard let docData = dataDescription!["spares"] as? [[String : Any]] else { return }
                            if(!docData.isEmpty){
                                docData.forEach({ (retrievedSpareItem) in
                                    let spareItem = item.createItem(spareName: retrievedSpareItem["name"] as! String, img_url: retrievedSpareItem["img_url"] as! String, price: retrievedSpareItem["price"] as! Int, quantity: retrievedSpareItem["quantity"] as! Int, carItem: retrievedSpareItem["carItem"] as! String, seller: retrievedSpareItem["seller"] as! String)
                                    user.cart.items.append(spareItem)
                                })
                            }
                            
                            
                            completion(.success(user))
                            // print("Document data: \(dataDescription)")
                            //   dump(user)
                        } else {
                            //completion(.failure(error!))
                            print("Document does not exist")
                        }
                        
                    }
                    
                }
                completion(.success(user))
               // print("Document data: \(dataDescription)")
             //   dump(user)
            } else {
                completion(.failure(error!))
                print("Document does not exist")
            }
            
        }
        
        
    }
    
    func setUserCar(carModel : String)
    {
        self.car.setCarModel(carModel: carModel)
        Firestore.firestore().collection("User").document("\(self.email)").updateData([
            "car": "\(carModel)"
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
        
    }
    
    func getUserEmail() -> String {
        return self.email
    }
    
    class func getUserLocation() ->CLLocationCoordinate2D
    {
        var defaultLoc = CLLocationCoordinate2DMake(29.964046,30.948015)//(30.031218, 31.21052)
        let locationManager = CLLocationManager()
        func checkForLocationService()
        {
            switch  CLLocationManager.authorizationStatus() {
            case .authorizedWhenInUse:
                //map.showsUserLocation = true
                locationManager.startUpdatingLocation()
            //moveCameraToUserLocation()
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
                
            default:
                break
            }
        }
        checkForLocationService()
        if CLLocationManager.locationServicesEnabled() {
            print("enableeeed")
            let temp = locationManager.delegate
            locationManager.delegate = temp
            locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            locationManager.startUpdatingLocation()
        }
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            defaultLoc = locations[locations.count - 1].coordinate
            //let myloc = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
            //userLocation = myloc
            if locations[locations.count - 1].horizontalAccuracy > 0{
                locationManager.stopUpdatingLocation()
                
                
                //  createMarker(titleMarker: "me", iconMarker: UIImage(named : "MapCar")!, snippet: "cairo uni", latitude: myloc.latitude, longitude: myloc.longitude)
                
            }
        }
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            
        }
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            checkForLocationService()
        }
        return defaultLoc
    }
    
}
