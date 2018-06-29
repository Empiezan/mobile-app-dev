//
//  ColorButton.swift
//  MichaelChang-Lab3
//
//  Created by labuser on 6/28/18.
//  Copyright © 2018 wustl. All rights reserved.
//
// Credits
// 1. How to create a custom UIButton by setting properties in required init (https://stackoverflow.com/questions/27079681/how-to-init-a-uibutton-subclass)
// 2. How to create a circular button (https://stackoverflow.com/questions/37770456/how-to-make-uibutton-a-circle)

import Foundation
import UIKit

class ColorButton : UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 0.5 * frame.width
        layer.masksToBounds = true
    }
    
    
    
}
