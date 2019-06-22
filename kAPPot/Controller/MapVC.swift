//
//  MapVC.swift
//  kAPPot
//
//  Created by YasserOsama on 6/8/19.
//  Copyright © 2019 macOS Mojave. All rights reserved.
//

import UIKit
import CoreLocation
import GooglePlaces
import MapKit

class MapVC: UIViewController , MKMapViewDelegate ,CLLocationManagerDelegate{
    
    
    @IBOutlet weak var map: MKMapView!
    
    
    var selectedShop = Shop()
    var AllShops = [Shop]()
    var action : String = ""
    let locationManager = CLLocationManager()
    var userLocation:CLLocationCoordinate2D!
    var destination:CLLocationCoordinate2D!
    
    
    
    override func viewDidLoad() {
        //super.viewDidLoad()
        loadUserLocation(){ () in
            if(self.action == "ShowAllShops"){
                self.AllShops.forEach({ (shop) in
                    shop.getLocations().forEach({ (location) in
                        self.createMarker(titleMarker: self.selectedShop.getShopName(), ShopLocation: location, subtitle: "\(self.selectedShop.getShopName()) for repair shops")
                    })
                })
            }
            if self.selectedShop.getLocations().count == 1 {
                let destination = CLLocationCoordinate2DMake(self.selectedShop.getLocations()[0]["lat"]!, self.selectedShop.getLocations()[0]["long"]!)
                self.createMarker(titleMarker: self.selectedShop.getShopName(), ShopLocation: self.selectedShop.getLocations()[0], subtitle: "\(self.selectedShop.getShopName()) for repair shops")
                self.drawPath(userLocation: self.userLocation, destination: destination)
            }
            else
            {
                self.selectedShop.getLocations().forEach { (location) in
                    self.createMarker(titleMarker: self.selectedShop.getShopName(), ShopLocation: location, subtitle: "\(self.selectedShop.getShopName()) for repair shops")
                }
            }
            self.map.delegate = self
            super.viewDidLoad()
        }
        
    }
    func loadUserLocation(completion : @escaping () -> ()) {
        self.userLocation = User.loggedInUser.getUserLocation()
        self.map.showsUserLocation = true
        completion()
        
    }
    func createMarker(titleMarker: String,ShopLocation: [String : Double],subtitle: String) {
        let annotation = MKPointAnnotation()
        
            annotation.coordinate = CLLocationCoordinate2DMake(ShopLocation["lat"]!, ShopLocation["long"]!)
        
            annotation.title = titleMarker
            annotation.subtitle = subtitle
            map.addAnnotation(annotation)
        
        
    }
    class func convertLatLongToAddress(latitude:Double, longitude:Double , completion: @escaping (Result<String,Error>) -> ()){
        
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: latitude, longitude: longitude)
        var address : String = ""
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
                
        // Place details
        var placeMark: CLPlacemark!
        placeMark = placemarks?[0]
            
        if placeMark.subLocality != nil {
            address = address + placeMark.subLocality! + ", "
        }
        if placeMark.thoroughfare != nil {
            address = address + placeMark.thoroughfare! + ", "
        }
        if placeMark.locality != nil {
            address = address + placeMark.locality! + ", "
        }
        if placeMark.country != nil {
            address = address + placeMark.country! + ", "
        }
        if placeMark.postalCode != nil {
            address = address + placeMark.postalCode! + " "
        }
                
        completion(.success(address))
       
        })
    }
    
    func drawPath(userLocation: CLLocationCoordinate2D, destination: CLLocationCoordinate2D )
    {
        let userPlaceMark = MKPlacemark(coordinate: userLocation)
        let destinationPlaceMark = MKPlacemark(coordinate: destination)
        let directionRequest = MKDirections.Request()
        directionRequest.source = MKMapItem(placemark: userPlaceMark)
        directionRequest.destination = MKMapItem(placemark: destinationPlaceMark)
        directionRequest.transportType = .automobile
        let directions = MKDirections(request: directionRequest)
        directions.calculate { (response, error) in
            guard let directionResponse = response else {
                if let error = error {
                    print(error)
                }
                return
            }
            let route = directionResponse.routes[0]
            self.map.removeOverlays(self.map.overlays)
            self.map.addOverlay(route.polyline, level: .aboveRoads)
            
            let routeRect = route.polyline.boundingMapRect
            self.map.setRegion(MKCoordinateRegion (routeRect), animated: true)
            //self.map.setRegion(routeRect, animated: true)
        }
    }
    func moveCameraToUserLocation() {
        //let location = locationManager.location?.coordinate
        let region = MKCoordinateRegion.init(center: self.userLocation, latitudinalMeters: 5000, longitudinalMeters: 5000)
        map.setRegion(region, animated: true)
        
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let render = MKPolylineRenderer(overlay: overlay)
        render.strokeColor = UIColor.red
        render.lineWidth = 4.0
        
        return render
    }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let annotationClickedCoordinates = view.annotation?.coordinate
        destination = annotationClickedCoordinates
        //drawPath(userLocation: User.getUserLocation(), destination: destination!)
    }
    
    
    @IBAction func DirectionsBu(_ sender: UIButton) {
        if destination == nil { return }
        drawPath(userLocation: userLocation, destination: destination)
    }
    
    
    
    @IBAction func MoveToCurrentLocation(_ sender: Any) {
        moveCameraToUserLocation()

    }
    
}


