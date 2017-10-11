//
//  UserSettings.swift
//  based-weather
//
//  Created by Andrew Zah on 10/9/17.
//  Copyright © 2017 Andrew Zah. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class UserSettings: Object {
    @objc dynamic public var primaryColor: Int = DAY_TEXT_COLOR
    @objc dynamic public var unitType: String = "si"
    @objc dynamic public var nightModeEnabled: Bool = false
    
    convenience init(unitType: String = "si", nightMode: Bool = false, color: Int = DAY_TEXT_COLOR) {
        self.init()
        self.unitType = unitType
        self.nightModeEnabled = nightMode
        self.primaryColor = color
    }
}
