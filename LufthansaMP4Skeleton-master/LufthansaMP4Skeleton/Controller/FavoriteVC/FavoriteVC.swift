//
//  FavoriteVC.swift
//  LufthansaMP4Skeleton
//
//  Created by Anik Gupta on 10/12/19.
//  Copyright © 2019 ___MaxAMiranda___. All rights reserved.
//

import UIKit

class FavoriteVC: UIViewController {
    var flights : [Flight]!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    var selectedFlight : Flight!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        flights = []
        
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "favoriteCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 50
        activityIndicator.isHidden = true
        //updateTable()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        updateTable()
        print("did something")
        
    }
    func updateTable(){
        flights = []

        //tableView.reloadData()
        let favorites = UserDefaults.standard.array(forKey: "favorites") as! [String]
        
        print(flights)
        let group = DispatchGroup()
        
        for fav in favorites{
            group.enter()
            print(favorites)
            let code = fav.components(separatedBy: " ")[0]
            let date = fav.components(separatedBy: " ")[1]
            
            LufthansaAPIClient.getFlightStatus(flightNum: code, date: date){flight in
                if !flight.isError(){
                    self.flights.append(flight)
                    
                }
                /*DispatchQueue.main.async {
                    
                    
                    print(self.flights)
                    self.tableView.reloadData()
                }*/
                group.leave()
                
            }
            
        }
        
        group.notify(queue: DispatchQueue.main, execute: {
            print(self.flights)
            self.flights.sort { (a, b) -> Bool in
                return a.flightNumber.compare(b.flightNumber).rawValue < 0
            }
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
        })
        //tableView.reloadData()
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //segue to detailed view
        if segue.identifier == "favoritesToDetail" {
            let controller =  segue.destination as! FlightDetailVC
            controller.flight = selectedFlight
            controller.favs = self
            let favorites = UserDefaults.standard.array(forKey: "favorites") as! [String]
            for fav in favorites{
                let code = fav.components(separatedBy: " ")[0]
                let date = fav.components(separatedBy: " ")[1]
                if code == selectedFlight.flightNumber{
                    controller.date = date
                    break
                    
                }
            }
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
