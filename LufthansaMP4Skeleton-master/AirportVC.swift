//
//  AirportVC.swift
//  LufthansaMP4Skeleton
//
//  Created by Anik Gupta on 10/12/19.
//  Copyright © 2019 ___MaxAMiranda___. All rights reserved.
//

import UIKit
import MapKit

class AirportVC: UIViewController {
    var airport: Airport!
    var location: CLLocationCoordinate2D!
    var locationManager: CLLocationManager!
    
    var departing: [Flight] = []
    var arriving: [Flight] = []
    var flights: [Flight] = []
    
    var selectedFlight : Flight!
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navBar: UINavigationItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        map.delegate = self
        //activityIndicator.startAnimating()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "tableCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 50
        //centerMap()
        if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse) {
            self.locationManager.requestLocation()
        }
        createAirport()
        setTable()
        // Do any additional setup after loading the view.
    }
    
    func setTable(){
        //let group = DispatchGroup()
        let date = Date()
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "yyyy-MM-dd'T'HH:mm"
        let dateString = dateFormatterPrint.string(from: date)
        LufthansaAPIClient.getFlights(arrivals_departures: "arrivals", code: airport.title!, date: dateString) { (arrivals) in
            self.arriving = arrivals
            self.flights = self.arriving
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
            LufthansaAPIClient.getFlights(arrivals_departures: "departures", code: self.airport.title!, date: dateString) { (departures) in
                self.departing = departures
                //print(self.departing)
            }
        }
        
    }
    
    @IBAction func controlPressed(_ sender: UISegmentedControl) {
        print("hey")
        if segmentedControl.selectedSegmentIndex == 0 {
            flights = arriving
        } else {
            flights = departing
        }
        print(flights)
        tableView.reloadData()
    }
    func setUI(){
        navBar.title = "\(airport.title!): \(airport.subtitle!)"
        
        
    }
    func createAirport(){
        self.map.addAnnotation(airport)
    }
    func centerMap() {
        var location = airport.coordinate
        
       var region = MKCoordinateRegion(center: location, latitudinalMeters: 1000000, longitudinalMeters: 1000000)
            self.map.setRegion(region, animated : true)
        print("centering")
        //self.map.setCenter(self.location, animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //segue to detailed view
        if segue.identifier == "airportToDetail" {
            let controller =  segue.destination as! FlightDetailVC
            controller.flight = selectedFlight
            controller.date = Date().description.components(separatedBy: " ")[0]
            /*let favorites = UserDefaults.standard.array(forKey: "favorites") as! [String]
            for fav in favorites{
                let code = fav.components(separatedBy: " ")[0]
                let date = fav.components(separatedBy: " ")[1]
                if code == selectedFlight.flightNumber{
                    controller.date = date
                    break
                    
                }
            }*/
        }
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
