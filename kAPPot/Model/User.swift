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
    var type : String = "user"
    var car = Car()
    var cart = Cart()
    var order = Order()
    
    override init() {
        
    }
    init(name : String , email : String , password : String , type : String)
    {
        self.name = name
        self.email = email
        self.password = password
        self.type = type
        
    }
    
    func signup() -> Bool
    {
        var bool = true
        Firestore.firestore().collection("User").document("\(self.email)").setData([
            "name" : "\(self.name)",
            "email" : "\(self.email)",
            "password" : "\(self.password)",
            "type" : "\(self.type)",
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
        print("sign in is called")
        var user = User()
        Firestore.firestore().collection("User").document("\(email)").getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data()
                guard let docData = dataDescription as? [String : String] else { return }
                if(docData["type"]! == "admin") { user = Admin(name: docData["name"]!, email: email, password: docData["password"]! , type : docData["type"]!) }
                else { user = User(name: docData["name"]!, email: email, password: docData["password"]! , type : docData["type"]!) }
                
                user.car.setCarModel(carModel: docData["car"]!)
                DispatchQueue.main.async {
                    user.cart.getCartItems(email: user.getUserEmail(), completion: { (res) in
                        switch res
                        {
                            case .success(let items):
                                    user.cart.items = items
                                    DispatchQueue.main.async {
                                        user.order.getOrder(email: user.getUserEmail(), completion: { (res2) in
                                            switch res2
                                            {
                                                
                                            case .success(let userOrder):
                                                user.order = userOrder
                                            
                                                 completion(.success(user))
                                            case .failure(let error):
                                                print(error)
                                            }
                                        })
                                    }
                            case .failure(let error):
                                print(error)
                        }
                    })
                }
               
               // print("Document data: \(dataDescription)")
             //   dump(user)
            } else {
                completion(.failure(error!))
                print("Document does not exist")
            }
            
        }
        
        
    }
    func getUserType() -> String {
        return self.type
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
    func getUserName() -> String {
        return self.name
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
    
    func addShopToCar(cartype : String , shop : Shop , ShopType : String) {
        let shopDictionary = ["shopName" : shop.getShopName() , "location" : shop.getLocations() , "rating" : shop.getRating() , "telephoneNo" : shop.getTelephoneNo()] as [String : Any]
        Firestore.firestore().collection("\(ShopType)").document("\(cartype)").updateData([
                "Shops": FieldValue.arrayUnion([shopDictionary])
                ])
    }
    
}
