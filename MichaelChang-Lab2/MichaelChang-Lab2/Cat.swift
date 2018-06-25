//
//  Cat.swift
//  MichaelChang-Lab2
//
//  Created by labuser on 6/23/18.
//  Copyright © 2018 wustl. All rights reserved.
//

import Foundation
import UIKit

class Cat : Pet {
    init(defaultFoodLocation: (Float, Float)) {
        super.init(color: UIColor.cyan, image: #imageLiteral(resourceName: "Cat"), food: FoodBag(defaultFoodLocation: defaultFoodLocation, image: #imageLiteral(resourceName: "Food Bag")))
    }
}
