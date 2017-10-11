//
//  CityCell.swift
//  based-weather
//
//  Created by Andrew Zah on 10/8/17.
//  Copyright © 2017 Andrew Zah. All rights reserved.
//

import UIKit
import NightNight

class CityCell: UITableViewCell {
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.mixedBackgroundColor = MixedColor(normal: DAY_BG_COLOR, night: NIGHT_BG_COLOR)
        self.textLabel?.mixedTextColor = MixedColor(normal: DAY_TEXT_COLOR, night: NIGHT_TEXT_COLOR)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        self.textLabel?.mixedTextColor = MixedColor(normal: DAY_TEXT_COLOR, night: NIGHT_TEXT_COLOR)
    }

}
