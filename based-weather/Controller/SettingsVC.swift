//
//  SettingsVC.swift
//  based-weather
//
//  Created by Andrew Zah on 10/8/17.
//  Copyright © 2017 Andrew Zah. All rights reserved.
//

import UIKit
import SideMenu
import NightNight

class SettingsVC: BaseVC, UITableViewDataSource, UITableViewDelegate {
    
    // Outlets
    @IBOutlet weak var citiesTableView: UITableView!
    @IBOutlet weak var unitTypesSegmentControl: UISegmentedControl!
    @IBOutlet weak var nightModeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var newCityBtn: UIButton!
    @IBOutlet weak var unitTypeLbl: UILabel!
    @IBOutlet weak var nightModeLbl: UILabel!
    @IBOutlet weak var colorLbl: UILabel!
    @IBOutlet weak var defaultColorBtn: CircleButton!
    
    // Variables
    var delegate: ActiveLocationDelegate? = nil
    let userSettings = RealmService.inst.getOrCreateUserSettings()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SideMenuManager.menuPushStyle = .subMenu
        citiesTableView.dataSource = self
        citiesTableView.delegate = self
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        setSegmentedControlValues()
    }
    
    override func setColors() {
        super.setColors()
        self.defaultColorBtn.mixedBackgroundColor = MIXED_TEXT_COLOR
        self.citiesTableView.mixedBackgroundColor = MixedColor(normal: DAY_BG_COLOR, night: NIGHT_BG_COLOR)
        self.nightModeSegmentedControl.mixedTintColor = MIXED_TEXT_COLOR
        self.unitTypesSegmentControl.mixedTintColor = MIXED_TEXT_COLOR
        self.newCityBtn.titleLabel?.mixedTextColor = MIXED_TEXT_COLOR
        self.newCityBtn.mixedTintColor = MIXED_TEXT_COLOR
        self.nightModeLbl.mixedTextColor = MIXED_TEXT_COLOR
        self.unitTypeLbl.mixedTextColor = MIXED_TEXT_COLOR
        self.colorLbl.mixedTextColor = MIXED_TEXT_COLOR
    }
    
    func setSegmentedControlValues() {
        if userSettings.unitType == "us" {
            unitTypesSegmentControl.selectedSegmentIndex = 1
        } else {
            unitTypesSegmentControl.selectedSegmentIndex = 0
        }
        
        if userSettings.nightModeEnabled == true {
            nightModeSegmentedControl.selectedSegmentIndex = 1
        } else {
            nightModeSegmentedControl.selectedSegmentIndex = 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RealmService.inst.getLocationsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell") as! CityCell
        let location = RealmService.inst.realm.objects(Location.self)[indexPath.row]
        cell.label.mixedTextColor = MixedColor(normal: DAY_LINE_COLOR, night: NIGHT_LINE_COLOR)
        cell.label.text = location.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CityCell
        cell.label.font = UIFont(name: "Gotham-Medium", size: 19)
        cell.backgroundColor = UIColor.clear
        
        RealmService.inst.tableUpdateActiveLocation(index: indexPath.row)
        if delegate != nil {
            delegate?.location = RealmService.inst.getLocation(index: indexPath.row)
            delegate?.updateWeatherOutletValues()
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CityCell
        cell.label.font = UIFont(name: "Gotham-Light", size: 19)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            RealmService.inst.deleteLocation(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    @IBAction func unitTypeSegmentValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            RealmService.inst.updateUserSettings(unitType: "si")
        } else {
            RealmService.inst.updateUserSettings(unitType: "us")
        }
        
        if delegate != nil {
            delegate?.updateWeatherOutletValues()
        }
    }
    
    @IBAction func nightModeSegmentValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            NightNight.theme = .normal
            RealmService.inst.updateUserSettings(nightMode: false)
        } else {
            NightNight.theme = .night
            RealmService.inst.updateUserSettings(nightMode: true)
        }
        
        if delegate != nil {
            delegate?.setColors()
        }
    }
    @IBAction func addCityBtnTapped(_ sender: Any) {
        performSegue(withIdentifier: TO_MAP, sender: nil)
    }
    
    @IBAction func circleButtonsPressed(_ sender: UIButton) {
        if let color = rgb(color: sender.backgroundColor!) {
            RealmService.inst.updateUserSettings(color: color)
            if delegate != nil {
                delegate?.setColors()
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
