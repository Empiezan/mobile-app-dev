//
//  Dog.swift
//  MichaelChang-Lab2
//
//  Created by labuser on 6/23/18.
//  Copyright © 2018 wustl. All rights reserved.
//

import Foundation
import UIKit

class Dog : Pet {
    init(defaultFoodLocation: (Float, Float)) {
        super.init(color: UIColor.red, image: #imageLiteral(resourceName: "Dog"), food: FoodBag(defaultFoodLocation: defaultFoodLocation, image: #imageLiteral(resourceName: "Food Bag")))
    }
}
