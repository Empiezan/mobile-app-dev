//
//  Bird.swift
//  MichaelChang-Lab2
//
//  Created by labuser on 6/23/18.
//  Copyright © 2018 wustl. All rights reserved.
//

import Foundation
import UIKit

class Bird : Pet {
    init(defaultFoodLocation: (Float, Float)) {
        super.init(color: UIColor.yellow, image: #imageLiteral(resourceName: "Bird"), food: FoodBag(defaultFoodLocation: defaultFoodLocation, image: #imageLiteral(resourceName: "Food Bag")))
    }
}
