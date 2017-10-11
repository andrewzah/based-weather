//
//  Functions.swift
//  based-weather
//
//  Created by Andrew Zah on 10/10/17.
//  Copyright © 2017 Andrew Zah. All rights reserved.
//

import Foundation
import UIKit

// https://stackoverflow.com/questions/19405228/how-to-i-properly-set-uicolor-from-int
func uiColorFromHex(rgbValue: Int) -> UIColor {
    
    // &  binary AND operator to zero out other color values
    // >>  bitwise right shift operator
    // Divide by 0xFF because UIColor takes CGFloats between 0.0 and 1.0
    
    let red =   CGFloat((rgbValue & 0xFF0000) >> 16) / 0xFF
    let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 0xFF
    let blue =  CGFloat(rgbValue & 0x0000FF) / 0xFF
    let alpha = CGFloat(1.0)
    
    return UIColor(red: red, green: green, blue: blue, alpha: alpha)
}

func rgb(color: UIColor) -> Int? {
    var fRed : CGFloat = 0
    var fGreen : CGFloat = 0
    var fBlue : CGFloat = 0
    var fAlpha: CGFloat = 0
    if color.getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: &fAlpha) {
        let iRed = Int(fRed * 255.0)
        let iGreen = Int(fGreen * 255.0)
        let iBlue = Int(fBlue * 255.0)
        let iAlpha = Int(fAlpha * 255.0)
        
        //  (Bits 24-31 are alpha, 16-23 are red, 8-15 are green, 0-7 are blue).
        let rgb = (iAlpha << 24) + (iRed << 16) + (iGreen << 8) + iBlue
        return rgb
    } else {
        // Could not extract RGBA components:
        return nil
    }
}
