//
//  ActiveLocation.swift
//  based-weather
//
//  Created by Andrew Zah on 10/9/17.
//  Copyright © 2017 Andrew Zah. All rights reserved.
//

import Foundation
import RealmSwift

class ActiveLocation: Object {
    @objc dynamic public var location: Location?
    
    convenience init(location: Location) {
        self.init()
        self.location = location
    }
}
