//
//  FlightDetailVC.swift
//  LufthansaMP4Skeleton
//
//  Created by Anik Gupta on 10/8/19.
//  Copyright © 2019 ___MaxAMiranda___. All rights reserved.
//

import UIKit

class FlightDetailVC: UIViewController {
    var flight: Flight!
    @IBOutlet weak var bar: UINavigationItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    @objc func handleToggleBT(sender: UIButton) {
        var favorites = [] as! [String]
        if UserDefaults.standard.array(forKey: "favorites") != nil{
            favorites = UserDefaults.standard.array(forKey: "favorites") as! [String]
            
        }
        if sender.isSelected {
            favorites.remove(at: favorites.index(of: flight.number)!) // FLIGHT NUMBER MAY NOT BE BEST IDENTIFIER
        }
        else {
            favorites.append(flight.number) // FLIGHT NUMBER MAY NOT BE BEST IDENTIFIER
        }
        
        UserDefaults.standard.set(favorites, forKey: "favorites")
        sender.isSelected = !sender.isSelected
        
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
