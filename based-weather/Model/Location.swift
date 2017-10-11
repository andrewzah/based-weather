//
//  Location.swift
//  based-weather
//
//  Created by Andrew Zah on 10/7/17.
//  Copyright © 2017 Andrew Zah. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class Location: Object {
    @objc dynamic public var coords = ""
    @objc dynamic public var name = ""
    
    @objc dynamic public private(set) var currentSummary = ""
    @objc dynamic public private(set) var currentTemp = 0
    @objc dynamic public private(set) var realfeelTemp = 0
    @objc dynamic public private(set) var dailyHigh = 0
    @objc dynamic public private(set) var dailyLow = 0
    @objc dynamic public private(set) var windSpeed = 0
    @objc dynamic public private(set) var windDirection = 0
    @objc dynamic public private(set) var humidity = 0
    @objc dynamic public private(set) var icon = ""
    public private(set) var lastJSONResponse: JSON? = nil
    
    convenience init(coords: String, name: String) {
        self.init()
        self.coords = coords
        self.name = name
    }
    
    func update(json: JSON) {
        let realm = try! Realm()
        try! realm.write {
            self.currentSummary = json["currently"]["summary"].stringValue
            self.currentTemp = json["currently"]["temperature"].intValue
            self.realfeelTemp = json["currently"]["apparentTemperature"].intValue
            self.dailyLow = json["daily"]["data"][0]["temperatureLow"].intValue
            self.dailyHigh = json["daily"]["data"][0]["temperatureHigh"].intValue
            self.windSpeed = json["currently"]["windSpeed"].intValue
            self.windDirection = json["currently"]["windBearing"].intValue
            self.humidity = Int(json["currently"]["humidity"].floatValue * 100)
            self.icon = json["currently"]["icon"].stringValue
        }
    }
    
    func getDegreeUnitSymbol() -> String {
        if RealmService.inst.getOrCreateUserSettings().unitType == "us" {
            return "ºF"
        } else {
            return "ºC"
        }
    }
    
    func getCurrentTempText() -> String {
        let symbol = getDegreeUnitSymbol()
        return "\(self.currentTemp)\(symbol)"
    }
    
    func getHighLowText() -> String {
        let symbol = getDegreeUnitSymbol()
        return "High: \(self.dailyHigh)\(symbol) | Low: \(self.dailyLow)\(symbol)"
    }
    
    func getRealfeelText() -> String {
        let symbol = getDegreeUnitSymbol()
        return "Realfeel: \(self.realfeelTemp)\(symbol)"
    }
    
    func getWindText() -> String {
        let direction = convertDegToWords(degree: self.windDirection)
        var unitType = RealmService.inst.getOrCreateUserSettings().unitType
        if unitType == "us" {
            unitType = "mph"
        } else {
            unitType = "m/s"
        }
        return "Wind: \(self.windSpeed) \(unitType) \(direction)"
    }
    
    // adapted from stack overflow
    func convertDegToWords(degree: Int) -> String {
        let val = Int((Double(degree)/22.5) + 0.5)
        var arr=["N","N-NE","NE","E-NE","E","E-SE", "SE", "S-SE","S","S-SW","SW","W-SW","W","W-NW","NW","N-NW"]
        let dir = arr[(val % 16)]
        return "going \(dir)"
    }
}
