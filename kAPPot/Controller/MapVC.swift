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
    
    let locationManager = CLLocationManager()
    var userLocation:CLLocationCoordinate2D!
    var destination:CLLocationCoordinate2D!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
            self.userLocation = User.getUserLocation()
            self.map.showsUserLocation = true
        
            moveCameraToUserLocation()
        if selectedShop.getLocations().count == 1 {
            let destination = CLLocationCoordinate2DMake(selectedShop.getLocations()[0]["lat"]!, selectedShop.getLocations()[0]["long"]!)
            drawPath(userLocation: self.userLocation, destination: destination)
        }
        else
        {
            selectedShop.getLocations().forEach { (location) in
                createMarker(titleMarker: selectedShop.getShopName(), ShopLocation: location, subtitle: "\(selectedShop.getShopName()) for repair shops")
            }
        }
            self.map.delegate = self
        
        
        
    }
    func loadUserLocation(completion: @escaping () -> ()) {
        self.userLocation = User.getUserLocation()
        completion()
        
    }
    func createMarker(titleMarker: String,ShopLocation: [String : Double],subtitle: String) {
        let annotation = MKPointAnnotation()
        
            annotation.coordinate = CLLocationCoordinate2DMake(ShopLocation["lat"]!, ShopLocation["long"]!)
        
            annotation.title = titleMarker
            annotation.subtitle = subtitle
            map.addAnnotation(annotation)
        
        
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
