//
//  MapVC - map.swift
//  LufthansaMP4Skeleton
//
//  Created by Anik Gupta on 10/12/19.
//  Copyright © 2019 ___MaxAMiranda___. All rights reserved.
//

import Foundation
import MapKit

extension MapVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        print("In MKMapViewDelegate")
        guard let annotation = annotation as? Airport else {
            return nil
        }
        let identifier = "marker"
        let view: MKMarkerAnnotationView
        if let dequeuedView = map.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            print("Created a new view")
            print(annotation.title)
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            let detailButton = UIButton(type: .detailDisclosure)
            view.rightCalloutAccessoryView = detailButton as! UIView
        }
        
        return view

    }
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if control == view.rightCalloutAccessoryView {
            //selectedAirport = control.
        //}
            performSegue(withIdentifier: "mapToAirport", sender: view)
        }
    }
    /*func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        //if control == view.rightCalloutAccessoryView {
            
        //}
    }*/

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "mapToAirport" )
        {
            print("working")
            var controller = segue.destination as! AirportVC
            controller.airport = (sender as! MKAnnotationView).annotation as! Airport
            //ikinciEkran.tekelName = (sender as! MKAnnotationView).annotation!.title

        }
    }
}
