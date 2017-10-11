//
//  RealmService.swift
//  based-weather
//
//  Created by Andrew Zah on 10/8/17.
//  Copyright © 2017 Andrew Zah. All rights reserved.
//

import Foundation
import RealmSwift

class RealmService {
    
    static let inst = RealmService()
    let realm: Realm!

    init() {
        let config = Realm.Configuration(
            //fileURL: Bundle.main.url(forResource: "default", withExtension: "realm"),
            schemaVersion: 2
        )
        Realm.Configuration.defaultConfiguration = config
        realm = try! Realm()
        seed()
    }
    
    func seed() {
        try! realm.write {
            realm.deleteAll()
        }
        
        let locations: [Location] =  [
            Location(coords: "36.3326,127.3846", name: "Daejeon"),
            Location(coords: "41.9741,-87.6514", name: "Chicago"),
            Location(coords: "34.0007,-81.0343", name: "Columbia"),
            Location(coords: "32.7174,-117.1628", name: "San Diego")
        ]
        
        for location in locations {
            try! realm.write {
                realm.add(location)
            }
        }
        
        let activeLocation = ActiveLocation(location: locations[0])
        try! realm.write {
            realm.add(activeLocation)
        }
        
        createUserSettings()
        
        self.updateActiveLocation(activeLocation: activeLocation, location: locations[1])
        print("finished seeding db")
    }
    
    func getLocations() -> Results<Location> {
        return realm.objects(Location.self)
    }
    
    func getLocationsCount() -> Int {
        return self.getLocations().count
    }
    
    func getLocation(index: Int) -> Location {
        return self.getLocations()[index]
    }
    
    func getOrCreateFirstLocation() -> Location {
        if let location = self.getLocations().first {
            return location
        } else {
            return createDefaultLocation()
        }
    }
    
    func createDefaultLocation() -> Location {
        let location = Location(coords: "41.9741,-87.6514", name: "Chicago")
        try! realm.write {
            realm.add(location)
        }
        return location
    }
    
    func deleteLocation(index: Int) {
        let location = self.getLocation(index: index)
        try! realm.write {
            realm.delete(location)
        }
    }
    
    func updateActiveLocation(activeLocation: ActiveLocation, location: Location) {
        try! realm.write {
            activeLocation.location = location
        }
    }
    
    func tableUpdateActiveLocation(index: Int) {
        let activeLocation = realm.objects(ActiveLocation.self).first
        let location = getLocation(index: index)
        
        updateActiveLocation(activeLocation: activeLocation!, location: location)
    }
    
    func getOrCreateUserSettings() -> UserSettings {
        if let settings = realm.objects(UserSettings.self).first {
            return settings
        } else {
            return createUserSettings()
        }
    }
    
    func createUserSettings() -> UserSettings {
        let userSettings = UserSettings()
        try! realm.write {
            realm.add(userSettings)
        }
        return userSettings
    }
    
    func updateUserSettings(nightMode: Bool) {
        let settings = getOrCreateUserSettings()
        try! realm.write {
            settings.nightModeEnabled = nightMode
        }
    }
    
    func updateUserSettings(unitType: String) {
        let settings = getOrCreateUserSettings()
        try! realm.write {
            settings.unitType = unitType
        }
    }
    
    func updateUserSettings(color: Int) {
        let settings = getOrCreateUserSettings()
        try! realm.write {
            settings.primaryColor = color
        }
    }
}
