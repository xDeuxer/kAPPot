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
    var name : String!
    var email : String!
    var password : String!
    
    init(name : String , email : String , password : String)
    {
        self.name = name
        self.email = email
        self.password = password
    }
    
    func signup()
    {
        
        
    }
    //func sign up
    
    
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
