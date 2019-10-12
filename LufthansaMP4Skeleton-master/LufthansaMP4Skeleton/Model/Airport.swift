//
//  Airport.swift
//  LufthansaMP4Skeleton
//
//  Created by Anik Gupta on 10/11/19.
//  Copyright © 2019 ___MaxAMiranda___. All rights reserved.
//

import Foundation
import MapKit

class Airport: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    
    init(location: CLLocationCoordinate2D, code: String) {
        title = code
        coordinate = location
    }
}
