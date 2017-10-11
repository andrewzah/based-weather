//
//  Constants.swift
//  based-weather
//
//  Created by Andrew Zah on 10/7/17.
//  Copyright © 2017 Andrew Zah. All rights reserved.
//

import Foundation
import UIKit
import NightNight

typealias CompletionHandler = (_ Success: Bool) -> ()

// URL - Example: https://api.darksky.net/forecast/{key}/37.8267,-122.4233/us12/en

let BASE_URL = "https://api.darksky.net/forecast/"
let API_KEY = "e07442ad5f05b44ccd0732a003937d9e" + "/"
let COORDINATES = "37.8267,-122.4233/"
let LOCALE = "en"
let API_URL = "\(BASE_URL)\(API_KEY)"

let HEADERS = [
    "Content-Type": "application/json; charset=utf-8",
    "User-Agent": "Andrew Zah"
]

// Segues

let TO_WEATHER_DETAIL = "toWeatherDetail"
let TO_MAP = "presentMap"

// Colors

let NIGHT_TEXT_COLOR = 0xFAFAFA
let NIGHT_BG_COLOR = 0x323232
let DAY_TEXT_COLOR = 0x323232
let DAY_BG_COLOR = 0xFAFAFA
let DAY_LINE_COLOR = 0x6F7179
let NIGHT_LINE_COLOR = 0xE4E4E4
let MIXED_TEXT_COLOR = MixedColor(normal: DAY_TEXT_COLOR, night: NIGHT_TEXT_COLOR)
