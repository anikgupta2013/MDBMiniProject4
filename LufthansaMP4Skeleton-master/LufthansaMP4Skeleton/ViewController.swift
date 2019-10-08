//
//  ViewController.swift
//  LufthansaMP4Skeleton
//
//  Created by Max Miranda on 3/2/19.
//  Copyright © 2019 ___MaxAMiranda___. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var image: UIImageView!
    var label: UILabel!
    var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
    }
    
    func initUI(){
        image = UIImageView(frame: CGRect(x: -300, y: 500, width: 300, height: 200))
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "plane")
        view.addSubview(image)

        label = UILabel(frame: CGRect(x: 0, y: 100, width: view.frame.width, height: 50))
        label.text = "This will be flight status"
        label.textAlignment = .center
        view.addSubview(label)
        
        button = UIButton(frame: CGRect(x: 50, y: 200, width: view.frame.width - 100, height: 50))
        button.backgroundColor = .blue
        button.setTitle("Get Flight Status", for: .normal)
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
        
        //Gets new auth token and then gets flight status once that is successful
        LufthansaAPIClient.getAuthToken() {
            LufthansaAPIClient.getFlightStatus(flightNum: "LH001", date: "2018-10-04") { flt in
                self.label.text = "fix the thing you dummy"
                self.animateImage()
            }
        }
    }

}

