//
//  FlightDetailVC-UI.swift
//  LufthansaMP4Skeleton
//
//  Created by Anik Gupta on 10/9/19.
//  Copyright © 2019 ___MaxAMiranda___. All rights reserved.
//

import Foundation
import UIKit
extension FlightDetailVC{
    func setUI(){
        let star = UIButton()
        
        if #available(iOS 13.0, *) {
            star.setImage(UIImage(systemName: "star"), for: .normal)
        } else {
            star.setImage(UIImage(named: "plane"), for: .normal)// Fallback on earlier versions
        }
        if #available(iOS 13.0, *) {
            star.setImage(UIImage(systemName: "star.fill"), for: .selected)
        } else {
             star.setImage(UIImage(named: "plane"), for: .normal)// Fallback on earlier versions
        }
        star.tintColor = .systemYellow
        star.addTarget(self, action: #selector(handleToggleBT), for: .touchUpInside)
        self.bar.rightBarButtonItem = UIBarButtonItem.init(customView: star)
        guard let favorites = UserDefaults.standard.array(forKey: "favorites") else{
            return
        }
        star.isSelected = (favorites as! [String]).contains(flight.number) // FLIGHT NUMBER MAY NOT BE BEST IDENTIFIER
    }
}
