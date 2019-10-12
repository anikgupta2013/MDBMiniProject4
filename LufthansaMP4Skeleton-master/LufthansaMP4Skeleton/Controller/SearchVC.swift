//
//  ViewController.swift
//  LufthansaMP4Skeleton
//
//  Created by Max Miranda on 3/2/19.
//  Copyright © 2019 ___MaxAMiranda___. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {

    var image: UIImageView!
    var label: UILabel!
    var flight: Flight!
    //var button: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var button: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
    }
    
    func initUI(){
        image = UIImageView(frame: CGRect(x: -300, y: 500, width: 300, height: 200))
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "plane")
        view.addSubview(image)

        /*label = UILabel(frame: CGRect(x: 0, y: 750, width: view.frame.width, height: 50))
        label.text = "This will be flight status"
        label.textAlignment = .center
        view.addSubview(label)*/
        
        /*button = UIButton(frame: CGRect(x: 50, y: 200, width: view.frame.width - 100, height: 50))
        button.backgroundColor = .blue
        button.setTitle("Get Flight Status", for: .normal)*/
        button.addTarget(self, action: #selector(buttonPress), for: .touchUpInside)
        view.addSubview(button)
    }
    
    func animateImage(){
        UIView.animate(withDuration: 4, animations: {
            self.image.frame = CGRect(x: self.view.frame.maxX + 300, y: 400, width: 300, height: 200)
        }) { (done) in
            self.image.frame = CGRect(x: -300, y: 500, width: 300, height: 200)
        }
    }
    
    @objc func buttonPress(_ sender: Any) {
        button.isEnabled = false
        //Gets new auth token and then gets flight status once that is successful
        guard textField.text != "" else{
            self.displayAlert(title: "No Flight Number", message: "Please include a flight number.")
            button.isEnabled = true
            return
        }
        self.animateImage()
        // TODO make sure date format is correct
        LufthansaAPIClient.getAuthToken() {
            LufthansaAPIClient.getFlightStatus(flightNum: self.textField.text!, date: self.datePicker.date.description.components(separatedBy: " ")[0]) { flt in
                /*self.label.text = "fix the thing you dummy"*/
                //self.animateImage()
                //print(flt.actualArrival)
                /*guard flt != nil else{
                    self.displayAlert(title: "No Flight Exists", message: "No flights with this number and date exist.")
                    return
                }*/
                /*if flt.isError(){
                    self.displayAlert(title: "No Flight Exists", message: "No flights with this number and date exist.")
                }
                else {*/
               
                self.flight = flt
                
                print(self.flight)
                if(!flt.isError()){
                    print("a")
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "searchToDetail", sender: self)
                        self.button.isEnabled = true
                    }
                }
                else{
                    print("b")
                    DispatchQueue.main.async {
                        self.displayAlert(title: "No Flight Exists", message: "No flights with this number and date exist.")
                        self.button.isEnabled = true
                    }
                }
                
               // }
                
            }
        }
        /*self.displayAlert(title: "No Flight Number", message: "Please include a flight number.")
        return*/
        
    }
    func displayAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(defaultAction)
        self.present(alert, animated: true, completion: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchToDetail" {
            let controller = segue.destination as! FlightDetailVC
            controller.flight = flight
            controller.date = datePicker.date.description.components(separatedBy: " ")[0]
        }
    }
}

