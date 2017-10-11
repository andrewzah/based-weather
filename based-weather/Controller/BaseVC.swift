//
//  BaseVC.swift
//  based-weather
//
//  Created by Andrew Zah on 10/9/17.
//  Copyright © 2017 Andrew Zah. All rights reserved.
//

import UIKit
import NightNight

class BaseVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let userSettings = RealmService.inst.getOrCreateUserSettings()
        if userSettings.nightModeEnabled == true {
            NightNight.theme = .night
        } else {
            NightNight.theme = .normal
        }

        setColors()
    }
    
    func setColors() {
        for view in self.view.subviews as [UIView] {
            if let label = view as? UILabel {
                label.mixedTextColor = MixedColor(normal: DAY_TEXT_COLOR, night: NIGHT_TEXT_COLOR)
            }
            if let btn = view as? UIButton {
                btn.titleLabel?.mixedTextColor = MixedColor(normal: DAY_TEXT_COLOR, night: NIGHT_TEXT_COLOR)
            }
            if let stackView = view as? UIStackView {
                for v in stackView.subviews as [UIView] {
                    if let label = v as? UILabel {
                        label.mixedTextColor = MixedColor(normal: DAY_TEXT_COLOR, night: NIGHT_TEXT_COLOR)
                    }
                }
            }
        }
        
        self.view.mixedBackgroundColor = MixedColor(normal: DAY_BG_COLOR, night: NIGHT_BG_COLOR)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
