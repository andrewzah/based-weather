//
//  HomeViewController.swift
//  based-weather
//
//  Created by Andrew Zah on 10/7/17.
//  Copyright © 2017 Andrew Zah. All rights reserved.
//

import UIKit
import SideMenu
import NightNight

class HomeViewController: BaseVC, ActiveLocationDelegate {
    
    // Outlets
    @IBOutlet var homeView: UIView!
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var refreshBtn: UIButton!
    @IBOutlet weak var locationNameLbl: UILabel!
    @IBOutlet weak var weatherIconIV: UIImageView!
    
    @IBOutlet weak var weatherStatusLbl: UILabel!
    @IBOutlet weak var currentTempLbl: UILabel!
    @IBOutlet weak var dailyHighLowLbl: UILabel!
    @IBOutlet weak var currentRealfeelLbl: UILabel!
    @IBOutlet weak var humidityLbl: UILabel!
    
    @IBOutlet weak var windSpeedAndDirectionLbl: UILabel!
    @IBOutlet weak var detailsStackView: UIStackView!
    
    public var location = RealmService.inst.getOrCreateFirstLocation()
    public var userSettings = RealmService.inst.getOrCreateUserSettings()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setColors()
        
        setupSideMenu()
        initGestures()
        updateWeatherOutletValues()
    }
    
    func setupSideMenu() {
        SideMenuManager.menuWidth = view.frame.width - 60
        SideMenuManager.menuPresentMode = .viewSlideInOut
        SideMenuManager.menuRightSwipeToDismissGesture = UIPanGestureRecognizer()
        SideMenuManager.menuDismissOnPush = false
    }
    
    override func setColors() {
        super.setColors()
        
        self.setWeatherIcon()
        
        menuBtn.imageView?.mixedImage = MixedImage(normal: UIImage(named: "menuButton-day")!, night: UIImage(named: "menuButton-night")!)
        
        if userSettings.primaryColor == DAY_TEXT_COLOR {
            currentTempLbl.mixedTextColor = MIXED_TEXT_COLOR
        } else {
            print("here")
            currentTempLbl.textColor = uiColorFromHex(rgbValue: userSettings.primaryColor)
        }
    }
    
    func initGestures() {
        let detailGesture = UITapGestureRecognizer(target: self, action: #selector (self.goToWeatherDetail (_:)))
        detailsStackView.addGestureRecognizer(detailGesture)
    }

    func setWeatherIcon() {
        if UIImage(named: "\(self.location.icon)-day") != nil {
            self.weatherIconIV.mixedImage = MixedImage(normal: "\(self.location.icon)-day", night: "\(self.location.icon)-night")
        } else {
            self.weatherIconIV.mixedImage = MixedImage(normal: "default-day", night: "default-night")
        }
    }
    
    func updateWeatherOutletValues() {
        DSAPIService.instance.updateWeatherData(location: location) { (success) in
            if success {
                self.locationNameLbl.text = self.location.name
                self.weatherStatusLbl.text = self.location.currentSummary
                self.currentTempLbl.text = self.location.getCurrentTempText()
                self.dailyHighLowLbl.text = self.location.getHighLowText()
                self.currentRealfeelLbl.text = self.location.getRealfeelText()
                self.windSpeedAndDirectionLbl.text = self.location.getWindText()
                self.humidityLbl.text = "Humidity: \(self.location.humidity)%"
                self.setWeatherIcon()
            }
        }
    }
    
    @objc func goToWeatherDetail(_ sender:UITapGestureRecognizer) {
        performSegue(withIdentifier: TO_WEATHER_DETAIL, sender: self)
    }
    
    // Temporarily flip from fahrenheit <-> celsius
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.currentTempLbl.text = convertTemperature(input: self.currentTempLbl.text!)
    }
    
    //undo
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.currentTempLbl.text = convertTemperature(input: self.currentTempLbl.text!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func refreshBtnPressed(_ sender: Any) {
        UIView.animate(withDuration: 0.7, animations: {
            self.refreshBtn.transform = self.refreshBtn.transform.rotated(by: CGFloat(Double.pi))
            self.view.layoutIfNeeded()
        })
        updateWeatherOutletValues()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == nil {
            let settingsVC = segue.destination.childViewControllers.first as! SettingsVC
            
            settingsVC.delegate = self
        }
    }
}
