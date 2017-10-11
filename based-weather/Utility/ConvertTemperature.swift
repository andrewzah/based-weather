//
//  ConvertTemperature.swift
//  based-weather
//
//  Created by Andrew Zah on 10/9/17.
//  Copyright © 2017 Andrew Zah. All rights reserved.
//

import Foundation
import UIKit

func convertTemperature(input: String) -> String {
    let array = input.split(separator: "º")
    let symbol: String?
    var val : Double = NSString(string: String(array[0])).doubleValue
    
    if array[1] == "F" {
        symbol = "C"
        val = (val - 32.0) * 5.0/9.0
    } else {
        symbol = "F"
        val = val * 9.0/5.0 + 32
    }
    
    
    return "\(Int(val))º\(symbol!)"
}
