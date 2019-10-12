//
//  LufthansaAPIClient.swift
//  LufthansaMP4Skeleton
//
//  Created by Max Miranda on 3/2/19.
//  Copyright © 2019 ___MaxAMiranda___. All rights reserved.
//

import Foundation
import Alamofire
import MapKit

class LufthansaAPIClient {
    //These are where we will store all of the authentication information. Get these from your account at developer.lufthansa.com.
    static let clientSecret = "" //FIXME
    static let clientID = "" //FIXME
    
    //This variable will store the session's auth token that we will get from getAuthToken()
    static var authToken: String?
    
    //This function will request an auth token from the lufthansa servers
    static func getAuthToken(completion: @escaping () -> ()){
        
        //This is the information that will be sent to the server to authenticate our device
        let requestURL = "" //FIXME
        let parameters = ["":""] //FIXME
        
        //GET RID OF THIS
        completion()
        
        //This is the POST request made to the lufthansa servers to get the authToken for this session.
        /*Alamofire.request(requestURL, method: /*FIXME*/ , parameters: parameters, encoding: URLEncoding(), headers: /*FIXME*/ ).responseJSON { response in
         
         //Converts response to JSON object and sets authToken variable to appropriate value
         let json = JSON() //FIXME
         self.authToken = ""//FIXME
         
         print("Auth token: " + self.authToken!)
         print("This key expires in " + json["expires_in"].stringValue + " seconds\n")
         
         //Runs completion closure
         completion()
         }*/
    }
    static func getAirport(code: String, completion: @escaping (CLLocationCoordinate2D) -> ()){
        let requestURL = "" //FIXME
        let parameters: HTTPHeaders = ["":""] //FIXME
        print(code)
        let headers = [
          "Accept": "application/json",
          "Authorization": "Bearer jcyxn87urfknnkuykp2cmxwy",
          "User-Agent": "PostmanRuntime/7.17.1",
          "Cache-Control": "no-cache",
          "Postman-Token": "a5f495a3-e6e0-4586-aba3-6f575fe20e49,127ad9dd-cab2-4760-91c2-c9668462b37d",
          "Host": "api.lufthansa.com",
          "Accept-Encoding": "gzip, deflate",
          "Connection": "keep-alive",
          "cache-control": "no-cache"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://api.lufthansa.com/v1/mds-references/airports/\(code)?limit=1&offset=0&LHoperated=0?")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                //print(httpResponse)
                guard let flightdata = data else{
                    return
                }
                do {
                    guard let jsonObject = try? JSONSerialization.jsonObject(with: flightdata, options: []) else {
                        print("Can't convert to JSON object")
                        return
                    }
                    guard let jsonDict = jsonObject as? [String: Any] else {
                        print("We can't cast to dictionary")
                        return
                    }
                    //print(jsonDict)
                    guard let flightstatusresource = jsonDict["AirportResource"] as? [String: Any] else{
                        print("There is bob error")
                        return
                    }
                    guard let flights = flightstatusresource["Airports"] as? [String: Any] else{
                        print("There is 2 error")
                        return
                    }
                    guard let flightDict = flights["Airport"] as? [String: Any] else{
                        print("There is 3 error")
                        return
                    }
                    guard let position = flightDict["Position"] as? [String: Any] else{
                        print("There is 4 error")
                        return
                    }
                    guard let coordinate = position["Coordinate"] as? [String: Any] else{
                        print("There is 5 error")
                        return
                    }
                    guard let latitude = coordinate["Latitude"] as? Double else{
                        print("There is 6 error")
                        return
                    }
                    guard let longitude = coordinate["Longitude"] as? Double else{
                        print("There is 7 error")
                        return
                    }
                    completion(CLLocationCoordinate2D(latitude: CLLocationDegrees(exactly: latitude)!, longitude: CLLocationDegrees(exactly: longitude)!))
                } catch let error {
                    print(error)
                }
            }
        })
        dataTask.resume()
    }
    
    
    static func getAircraft(code: String, completion: @escaping (String) -> ()){
        let requestURL = "" //FIXME
        let parameters: HTTPHeaders = ["":""] //FIXME
            
        let headers = [
          "Accept": "application/json",
          "Authorization": "Bearer jcyxn87urfknnkuykp2cmxwy",
          "User-Agent": "PostmanRuntime/7.17.1",
          "Cache-Control": "no-cache",
          "Postman-Token": "a5f495a3-e6e0-4586-aba3-6f575fe20e49,127ad9dd-cab2-4760-91c2-c9668462b37d",
          "Host": "api.lufthansa.com",
          "Accept-Encoding": "gzip, deflate",
          "Connection": "keep-alive",
          "cache-control": "no-cache"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://api.lufthansa.com/v1/mds-references/aircraft/\(code)?limit=1&offset=0")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                //print(httpResponse)
                guard let flightdata = data else{
                    completion("a b")
                    return
                }
                do {
                    guard let jsonObject = try? JSONSerialization.jsonObject(with: flightdata, options: []) else {
                        print("Can't convert to JSON object")
                        completion("a b")
                        return
                    }
                    guard let jsonDict = jsonObject as? [String: Any] else {
                        print("We can't cast to dictionary")
                        completion("a b")
                        return
                    }
                    //print(jsonDict)
                    guard let flightstatusresource = jsonDict["AircraftResource"] as? [String: Any] else{
                        print("There is error \(code)")
                        completion("a b")
                        return
                    }
                    guard let flights = flightstatusresource["AircraftSummaries"] as? [String: Any] else{
                        print("There is 2 error")
                        completion("a b")
                        return
                    }
                    guard let flightDict = flights["AircraftSummary"] as? [String: Any] else{
                        print("There is 3 error")
                        completion("a b")
                        return
                    }
                    guard let names = flightDict["Names"] as? [String: Any] else{
                        print("There is 3 error")
                        completion("a b")
                        return
                    }
                    guard let namegroup = names["Name"] as? [String: Any] else{
                        print("There is 3 error")
                        completion("a b")
                        return
                    }
                    guard let name = namegroup["$"] as? String else{
                        print("There is 3 error")
                        completion("a b")
                        return
                    }
                    completion(name)
                } catch let error {
                    print(error)
                }
            }
        })
        dataTask.resume()
    }
        
    //This function will get the status for a flight. FlightNum format "LHXXX" Date format "YYYY-MM-DD"
    static func getFlightStatus(flightNum: String, date: String, completion: @escaping (Flight) -> ()){
        
        //Request URL and authentication parameters
        let requestURL = "" //FIXME
        let parameters: HTTPHeaders = ["":""] //FIXME
        
        let headers = [
          "Accept": "application/json",
          "Authorization": "Bearer jcyxn87urfknnkuykp2cmxwy",
          "User-Agent": "PostmanRuntime/7.17.1",
          "Cache-Control": "no-cache",
          "Postman-Token": "a5f495a3-e6e0-4586-aba3-6f575fe20e49,127ad9dd-cab2-4760-91c2-c9668462b37d",
          "Host": "api.lufthansa.com",
          "Accept-Encoding": "gzip, deflate",
          "Connection": "keep-alive",
          "cache-control": "no-cache"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://api.lufthansa.com/v1/operations/flightstatus/\(flightNum)/\(date)?limit=1")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
          if (error != nil) {
            print(error)
          } else {
            let httpResponse = response as? HTTPURLResponse
            //print(httpResponse)
            guard let flightdata = data else{
                completion(Flight(flightDict: [:]))
                return
            }
            do {
                guard let jsonObject = try? JSONSerialization.jsonObject(with: flightdata, options: []) else {
                    print("Can't convert to JSON object")
                    completion(Flight(flightDict: [:]))
                    return
                }
                guard let jsonDict = jsonObject as? [String: Any] else {
                    print("We can't cast to dictionary")
                    completion(Flight(flightDict: [:]))
                    return
                }
                //print(jsonDict)
                guard let flightstatusresource = jsonDict["FlightStatusResource"] as? [String: Any] else{
                    print("There is 1 error")
                    completion(Flight(flightDict: [:]))
                    return
                }
                guard let flights = flightstatusresource["Flights"] as? [String: Any] else{
                    print("There is 2 error")
                    completion(Flight(flightDict: [:]))
                    return
                }
                guard let flightDict = flights["Flight"] as? [String: Any] else{
                    print("There is 3 error")
                    completion(Flight(flightDict: [:]))
                    return
                }
                /*guard let allCatFacts = jsonDict["all"] as? [[String: Any]] else {
                    print("We can't cast to dictionary")
                    return
                }
            
                var catFactsModelObjects = [CatFact]()
                for catFactDict in allCatFacts {
                    catFactsModelObjects.append(CatFact(catFactDict))
                }
                print(catFactsModelObjects)*/
                //print(flightDict)
                
                print("here")
                let flight = Flight(flightDict: flightDict)
                print("here")
                if let equip = flightDict["Equipment"] as? [String: Any]{
                    print("here")
                    if let code = equip["AircraftCode"]{
                        print("here")
                        LufthansaAPIClient.getAircraft(code: "\(code)"){type in
                            
                            if type == "a b"{
                                flight.aircraftType = nil
                            }
                            else{
                                flight.aircraftType = type.components(separatedBy: " ")[0] + " " + type.components(separatedBy: " ")[1]
                            }
                            completion(flight)
                        }
                    }
                }
                
            } catch let error {
                print(error)
            }
          }
        })

        dataTask.resume()
        //print("PARAMETERS FOR REQUEST:")
        //print(parameters)
        //print("\n")
        
        //GET RID OF THIS
        
        
        /*Alamofire.request(requestURL, headers: parameters).responseJSON { response in
         //Makes sure that response is valid
         guard response.result.isSuccess else {
         print(response.result.error.debugDescription)
         return
         }
         //Creates JSON object
         let json = JSON() //FIXME
         print(json)
         //Create new flight model and populate data
         let flight = Flight()
         //FIXME
         completion(flight)
         }*/
    }
    
}
