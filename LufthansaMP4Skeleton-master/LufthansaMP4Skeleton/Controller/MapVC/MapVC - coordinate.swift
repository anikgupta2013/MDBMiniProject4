//
//  MapVC - coordinate.swift
//  LufthansaMP4Skeleton
//
//  Created by Anik Gupta on 10/12/19.
//  Copyright © 2019 ___MaxAMiranda___. All rights reserved.
//

import Foundation
import CoreLocation

extension MapVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.last?.coordinate
        centerMap()
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
