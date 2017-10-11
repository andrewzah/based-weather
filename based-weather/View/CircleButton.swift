//
//  ColorButton.swift
//  based-weather
//
//  Created by Andrew Zah on 10/10/17.
//  Copyright © 2017 Andrew Zah. All rights reserved.
//

import UIKit

class CircleButton: UIButton {

    override func awakeFromNib() {
        self.layer.cornerRadius = self.bounds.width / 2
    }

}
