//
//  CLLocation.swift
//  kAPPot
//
//  Created by YasserOsama on 6/18/19.
//  Copyright © 2019 macOS Mojave. All rights reserved.
//

import Foundation
import CoreLocation

extension CLLocation {
    class func distance(from: CLLocationCoordinate2D, to: CLLocationCoordinate2D) -> CLLocationDistance {
        let from = CLLocation(latitude: from.latitude, longitude: from.longitude)
        let to = CLLocation(latitude: to.latitude, longitude: to.longitude)
        return from.distance(from: to)
    }
}
