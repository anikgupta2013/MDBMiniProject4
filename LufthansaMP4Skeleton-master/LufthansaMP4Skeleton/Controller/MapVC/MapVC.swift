//
//  MapVCViewController.swift
//  LufthansaMP4Skeleton
//
//  Created by Anik Gupta on 10/12/19.
//  Copyright © 2019 ___MaxAMiranda___. All rights reserved.
//

import UIKit
import MapKit

class MapVC: UIViewController {
    var location: CLLocationCoordinate2D!
    var locationManager: CLLocationManager!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var map: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
        map.delegate = self
        //activityIndicator.startAnimating()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        //centerMap()
        if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse) {
            self.locationManager.requestLocation()
        }
        createAirports()
        // Do any additional setup after loading the view.
    }
    
    func centerMap() {
       var location = CLLocationCoordinate2D(latitude: 36.8222, longitude: 7.8092)
        
       var region = MKCoordinateRegion(center: location, latitudinalMeters: 10000000, longitudinalMeters: 10000000)
            self.map.setRegion(region, animated : true)
        print("centering")
        //self.map.setCenter(self.location, animated: true)
    }
    
    func createAirports() {
        for i in stride(from: 0, to: 1100, by: 100) {
            LufthansaAPIClient.getAirports(offset: "\(i)" ){ (airports) in
                
                self.map.addAnnotations(airports)
            }
            

        }
        //self.activityIndicator.stopAnimating()
        //self.activityIndicator.isHidden = true
        /*let start = Airport(location: CLLocationCoordinate2D(latitude: 37.866632800000005, longitude: -122.25206805335353), code: "JFK")
        let end = Airport(location: CLLocationCoordinate2D(latitude: 45.866632800000005, longitude: -122.25206805335353), code: "FRA")*/
        
        //map.addAnnotation(end)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
