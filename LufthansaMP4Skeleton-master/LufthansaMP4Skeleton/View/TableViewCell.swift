//
//  TableViewCell.swift
//  LufthansaMP4Skeleton
//
//  Created by Anik Gupta on 10/12/19.
//  Copyright © 2019 ___MaxAMiranda___. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    
    var flight: Flight? {
        didSet {
            if let flight = flight {
                let dateFormatterPrint = DateFormatter()
                dateFormatterPrint.dateFormat = "MMM dd h:mm a"
                flightNumber.text = "#\(flight.flightNumber!)"
                
                if flight.arrivalAirport != nil{
                    flightArrival.text = flight.arrivalAirport!
                }
                if flight.departureAirport != nil{
                    flightDeparture.text = flight.departureAirport!
                }
                if flight.scheduledDeparture != nil{
                    flightTime.text = dateFormatterPrint.string(from: flight.scheduledDeparture!)
                }
                /*eventCreator.text = "Created by: " + event.creator
                attendeeNumber.text = "\(event.interested.count)"
                eventTitle.text = event.title
                eventImage.image = event.image*/
            }
        }
    }
    var flightNumber: UILabel!
    var flightArrival: UILabel!
    var flightDeparture: UILabel!
    var flightTime: UILabel!
    /*var eventCreator: UILabel!
    var attendeeNumber: UILabel!*/
    var icon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func initCellFrom(size: CGSize) {
        
        
        flightNumber = UILabel(frame: CGRect(x: 20, y: (size.height-30)/2, width: size.width-20, height: 30))
        contentView.addSubview(flightNumber)
        
        /*eventCreator = UILabel(frame: CGRect(x: 20, y: eventTitle.frame.maxY-70, width: size.width-20, height: 30))
        eventCreator.text = ""
        eventCreator.numberOfLines = 1
        eventCreator.adjustsFontSizeToFitWidth = true
        eventCreator.minimumScaleFactor = 0.3
        eventCreator.font = UIFont(name: "Helvetica-SemiBold", size: 25)
        eventCreator.textColor = .white
        eventCreator.textAlignment = .left
        contentView.addSubview(eventCreator)*/
        
        icon = UIImageView(frame: CGRect(x: size.width/2 - 40, y: (size.height-30)/2, width: 30, height: 30))
        icon.contentMode = .scaleAspectFit
        if #available(iOS 13.0, *) {
            icon.image = UIImage(systemName: "airplane")
        } else {
            icon.image = UIImage(named: "plane")
        }
        icon.tintColor = .black
        contentView.addSubview(icon)
        
        
        flightDeparture = UILabel(frame: CGRect(x: icon.frame.minX - 50, y: (size.height-30)/2, width: 40, height: 30))
        contentView.addSubview(flightDeparture)
        flightArrival = UILabel(frame: CGRect(x: icon.frame.maxX + 20, y: (size.height-30)/2, width: 40, height: 30))
        contentView.addSubview(flightArrival)
        
        
        flightTime = UILabel(frame: CGRect(x: size.width-130, y: (size.height-30)/2, width: size.width-10, height: 30))
        flightTime.textColor = .systemGray
        flightTime.font = UIFont(name: "Helvetica", size: 16)
        contentView.addSubview(flightTime)
        /*attendeeNumber = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        attendeeNumber.center = CGPoint(x: icon.frame.midX, y: icon.frame.maxY + 20)
        attendeeNumber.adjustsFontSizeToFitWidth = true
        attendeeNumber.minimumScaleFactor = 0.3
        attendeeNumber.font = UIFont(name: "Helvetica-Medium", size: 26)
        attendeeNumber.textColor = .white
        attendeeNumber.textAlignment = .center
        contentView.addSubview(attendeeNumber)*/
    }
}
