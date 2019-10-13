//
//  FlightDetailVC.swift
//  LufthansaMP4Skeleton
//
//  Created by Anik Gupta on 10/8/19.
//  Copyright © 2019 ___MaxAMiranda___. All rights reserved.
//

import UIKit
import MapKit

class FlightDetailVC: UIViewController {
    var flight: Flight!
    var date: String!
    @IBOutlet weak var bar: UINavigationItem!
    @IBOutlet weak var flightImage: UIImageView!
    @IBOutlet weak var actualDepartureLabel: UILabel!
    @IBOutlet weak var scheduleDepartureLabel: UILabel!
    @IBOutlet weak var aircraftTypeLabel: UILabel!
    @IBOutlet weak var scheduleArrivalLabel: UILabel!
    @IBOutlet weak var actualArrivalLabel: UILabel!
    @IBOutlet weak var departureLabel: UILabel!
    @IBOutlet weak var departureLocationLabel: UILabel!
    @IBOutlet weak var arrivalLabel: UILabel!
    @IBOutlet weak var arrivalLocationLabel: UILabel!
    @IBOutlet weak var map: MKMapView!
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    
    var location: CLLocationCoordinate2D!
    var locationManager: CLLocationManager!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        initialize()
        map.delegate = self

        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        //centerMap()
        if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse) {
            self.locationManager.requestLocation()
        }
        createAirports()
    }
    
    func initialize(){
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd h:mm a"
        if flight.flightNumber != nil{
            bar.title = "Flight Number: \(flight.flightNumber!)"
        }
        print(flight.aircraftType)
        if flight.aircraftType != nil{
            aircraftTypeLabel.text = flight.aircraftType! + "\n"
        }
        else{
            aircraftTypeLabel.isHidden = true
        }
        
        if flight.arrivalAirport != nil{
            arrivalLabel.text = flight.arrivalAirport!
        }
        else{
            arrivalLabel.isHidden = true
        }
        if flight.departureAirport != nil{
            departureLabel.text = flight.departureAirport!
        }
        else{
            departureLabel.isHidden = true
        }
        //print(flight.actualDeparture)
        if flight.actualDeparture != nil{
            actualDepartureLabel.text = "Actual Departure\n\(dateFormatterPrint.string(from: flight.actualDeparture!))"
        }
        else {
            actualDepartureLabel.isHidden = true
        }
        if flight.actualArrival != nil{
            actualArrivalLabel.text = "Actual Arrival\n\(dateFormatterPrint.string(from: flight.actualArrival!))"
        }
        else {
            actualArrivalLabel.isHidden = true
        }
        if flight.scheduledDeparture != nil{
            scheduleDepartureLabel.text = "Departure\n\(dateFormatterPrint.string(from: flight.scheduledDeparture!))"
        }
        else {
            scheduleDepartureLabel.isHidden = true
        }
        if flight.scheduledArrival != nil{
            scheduleArrivalLabel.text = "Arrival\n\(dateFormatterPrint.string(from: flight.scheduledArrival!))"
        }
        else {
            scheduleArrivalLabel.isHidden = true
        }
        
        if flight.status != nil{
            statusLabel.text = "Status\n\(flight.status!)"
        }
        else{
            statusLabel.isHidden = true
        }
        
        
        if flight.terminalArrival != nil{
            arrivalLocationLabel.text = "Terminal: " + flight.terminalArrival! + "\n"
        }
        if flight.gateArrival != nil{
            arrivalLocationLabel.text! += "Gate: " + flight.gateArrival!
        }
        
        if flight.terminalDeparture != nil{
            departureLocationLabel.text = "Terminal: " + flight.terminalDeparture! + "\n"
        }
        if flight.gateDeparture != nil{
            departureLocationLabel.text! += "Gate: " + flight.gateDeparture!
        }
        
    }
    
    @objc func handleToggleBT(sender: UIButton) {
        var favorites = [] as! [String]
        if UserDefaults.standard.array(forKey: "favorites") != nil{
            favorites = UserDefaults.standard.array(forKey: "favorites") as! [String]
            
        }
        if sender.isSelected {
            favorites.remove(at: favorites.index(of: flight.flightNumber! + " " + date)!) // FLIGHT NUMBER MAY NOT BE BEST IDENTIFIER
        }
        else {
            favorites.append(flight.flightNumber! + " " + date) // FLIGHT NUMBER MAY NOT BE BEST IDENTIFIER
        }
        
        UserDefaults.standard.set(favorites, forKey: "favorites")
        sender.isSelected = !sender.isSelected
        
    }
    
    func centerMap() {
       // var location = CLLocationCoordinate2D(latitude: 37.87, longitude: -122.27)
            /*var region = MKCoordinateRegion(center: self.location, latitudinalMeters: 1000, longitudinalMeters: 1000)
            self.map.setRegion(region, animated : true)*/
    }
    
    func createAirports() {
        
        if flight.departureAirport != nil{
            LufthansaAPIClient.getAirport(code: flight.departureAirport!){(begin) in
                //let start = Airport(location: begin, code: self.flight.departureAirport!)
                //print(begin)
                if self.flight.arrivalAirport != nil{
                    print("Good 1")
                    LufthansaAPIClient.getAirport(code: self.flight.arrivalAirport!){(fin) in
                        print("Good 2")
                        //let end = Airport(location: fin, code: self.flight.arrivalAirport!)
                        let places = [begin, fin]
                        print("Good 3")
                        self.map.addAnnotations(places)
                        //var locations = places.map { $0.coordinate }
                        var locations = places.map { (airport) -> CLLocationCoordinate2D in
                            airport.coordinate
                        }
                        print(locations)
                        print("Good 4")
                        let polyline = MKPolyline(coordinates: &locations, count: locations.count)
                        print("Good 5")
                        DispatchQueue.main.async {
                            self.map.addOverlay(polyline)
                        }
                        
                        //self.map.addOverlay(polyline)
                        print("Good 6")
                    }
                }
            }
        }
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
