//
//  FoodBag.swift
//  MichaelChang-Lab2
//
//  Created by labuser on 6/24/18.
//  Copyright © 2018 wustl. All rights reserved.
//

import Foundation
import UIKit

class FoodBag : UIImageView{
    private var size = 3
    private var location = CGPoint(x: 0, y: 0)
    
    init() {
        super.init(image: #imageLiteral(resourceName: "Food Bag"))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getLocation() -> CGPoint {
        return location
    }
    
    func setLocation(loc : CGPoint) {
        location = loc
    }
    
    func eatFromBag() {
        if size > 0 {
            size -= 1
        }
        print(size)
    }
}
