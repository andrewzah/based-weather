//
//  ActiveLocationDelegate.swift
//  based-weather
//
//  Created by Andrew Zah on 10/8/17.
//  Copyright © 2017 Andrew Zah. All rights reserved.
//

import Foundation
import UIKit

protocol ActiveLocationDelegate {
    var location: Location { get set }
    func updateWeatherOutletValues()
    func setColors()
}
