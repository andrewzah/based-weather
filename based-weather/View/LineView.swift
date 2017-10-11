//
//  LineView.swift
//  based-weather
//
//  Created by Andrew Zah on 10/9/17.
//  Copyright © 2017 Andrew Zah. All rights reserved.
//

import UIKit
import NightNight

class LineView: UIView {

    override func awakeFromNib() {
        self.mixedBackgroundColor = MixedColor(normal: DAY_LINE_COLOR, night: NIGHT_LINE_COLOR)
    }

}
