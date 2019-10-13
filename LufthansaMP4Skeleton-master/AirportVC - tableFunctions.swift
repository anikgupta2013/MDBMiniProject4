//
//  AirportVC - tableFunctions.swift
//  LufthansaMP4Skeleton
//
//  Created by Anik Gupta on 10/12/19.
//  Copyright © 2019 ___MaxAMiranda___. All rights reserved.
//

import UIKit

extension AirportVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flights.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var index = indexPath[1]
        //let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as! TableViewCell
        let cell = TableViewCell()
        cell.awakeFromNib()
        let size = CGSize(width: tableView.frame.width, height: height(for: indexPath))
        cell.initCellFrom(size: size)
        cell.selectionStyle = .none
        print("F \(flights)")
        cell.flight = flights[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var index = indexPath[1]
        selectedFlight = flights[index]
        performSegue(withIdentifier: "airportToDetail", sender: self)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return height(for: indexPath)
    }
    
    func height(for index: IndexPath) -> CGFloat {
        return 50
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
