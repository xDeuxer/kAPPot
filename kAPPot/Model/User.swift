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
    
    
    //user attributes in db
    var name : String = ""
    var email : String = ""
    var password : String = ""
    var car = Car()
    var cart = Cart()
    
    init(name : String , email : String , password : String)
    {
        self.name = name
        self.email = email
        self.password = password
    }
    
    func signup() -> Bool
    {
        var bool = false
        Firestore.firestore().collection("User").document("\(self.email)").setData([
            "name" : "",
            "email" : "",
            "password" : "",
            "car" : ""
        ]) { err in
            if let err = err {
                
                print("Error writing document: \(err)")
            } else {
                bool = true
                print("Document successfully written!")
            }
        }
        return bool
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
    
    class func getUserLocation() -> CLLocationCoordinate2D
    {
        let defaultLoc = CLLocationCoordinate2DMake(30.031218, 31.21052)
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
            let location = locations[locations.count - 1]
            //let myloc = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
            //userLocation = myloc
            if location.horizontalAccuracy > 0{
                locationManager.stopUpdatingLocation()
                
                //  createMarker(titleMarker: "me", iconMarker: UIImage(named : "MapCar")!, snippet: "cairo uni", latitude: myloc.latitude, longitude: myloc.longitude)
                
            }
        }
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print(error)
        }
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            checkForLocationService()
        }
        return (locationManager.location?.coordinate)! 
    }
}
