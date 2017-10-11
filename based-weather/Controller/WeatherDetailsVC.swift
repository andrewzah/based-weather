//
//  WeatherDetailsVC.swift
//  based-weather
//
//  Created by Andrew Zah on 10/7/17.
//  Copyright © 2017 Andrew Zah. All rights reserved.
//

import UIKit
import NightNight

class WeatherDetailsVC: BaseVC {

    // Outlets
    @IBOutlet weak var backBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn.imageView?.mixedImage = MixedImage(normal: UIImage(named: "backBtn-day")!, night: UIImage(named: "backBtn-night")!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
