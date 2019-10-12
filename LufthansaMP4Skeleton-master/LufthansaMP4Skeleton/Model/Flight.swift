//
//  Flight.swift
//  LufthansaMP4Skeleton
//
//  Created by Max Miranda on 3/2/19.
//  Copyright © 2019 ___MaxAMiranda___. All rights reserved.
//

import Foundation

class Flight {
    //FIXME
    var flightNumber: String!
    
    var departureAirport: String?
    var scheduledDeparture: Date?
    var actualDeparture: Date?
    var terminalDeparture: String?
    var gateDeparture: String?
    
    var arrivalAirport: String?
    var scheduledArrival: Date?
    var actualArrival: Date?
    var terminalArrival: String?
    var gateArrival: String?
    
    var status: String?
    var aircraftType: String?

    init(flightDict: [String: Any?]){
        //print(flightDict)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        if let departure = flightDict["Departure"] as? [String: Any]{
            departureAirport = departure["AirportCode"] as? String
            if let dateSchedule = departure["ScheduledTimeLocal"] as? [String: Any]{
                scheduledDeparture = dateFormatter.date(from:dateSchedule["DateTime"] as! String)!
            }
            if let dateActual = departure["ActualTimeLocal"] as? [String: Any]{
                actualDeparture = dateFormatter.date(from:dateActual["DateTime"] as! String)!
            }
            if let terminal = departure["Terminal"] as? [String: Any]{
                //print(terminal["Name"] as! Int)
                terminalDeparture = "\(terminal["Name"]!)"
                gateDeparture = terminal["Gate"] as? String
            }
        }
        
        if let arrival = flightDict["Arrival"] as? [String: Any]{
            arrivalAirport = arrival["AirportCode"] as! String
            if let dateSchedule = arrival["ScheduledTimeLocal"] as? [String: Any]{
                scheduledArrival = dateFormatter.date(from:dateSchedule["DateTime"] as! String)!
            }
            if let dateActual = arrival["ActualTimeLocal"] as? [String: Any]{
                actualArrival = dateFormatter.date(from:dateActual["DateTime"] as! String)!
            }
            if let terminal = arrival["Terminal"] as? [String: Any]{
                terminalArrival = "\(terminal["Name"]!)"
                
                gateArrival = terminal["Gate"] as? String
            }
        }
        if let flightStatus = flightDict["FlightStatus"] as? [String: Any]{
            //print(flightStatus)
            status = flightStatus["Definition"] as? String
        }
        
        /*"OperatingCarrier": {
            "AirlineID": "LH",
            "FlightNumber": 400
        }*/
        flightNumber = ""
        if let carrier = flightDict["MarketingCarrier"] as? [String: Any]{
            if let airline = carrier["AirlineID"] as? String{
                flightNumber += airline// + number
            }
            if let number = carrier["FlightNumber"] as? Int {
                //print(number)
                flightNumber += String(number)
            }
            
            //}
        }
        
        /*if let equip = flightDict["Equipment"] as? [String: Any]{
            if let code = equip["AircraftCode"] as? Int{
                LufthansaAPIClient.getAircraft(code: String(code)){type in
                    self.aircraftType = type
                    print(self.aircraftType)
                }
            }
        }*/
        
    }
    func isError() -> Bool{
        return flightNumber == ""
    }
}
