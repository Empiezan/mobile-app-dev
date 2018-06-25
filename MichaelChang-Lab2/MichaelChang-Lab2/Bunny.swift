//
//  Bunny.swift
//  MichaelChang-Lab2
//
//  Created by labuser on 6/23/18.
//  Copyright © 2018 wustl. All rights reserved.
//

import Foundation
import UIKit

class Bunny : Pet {
    init(defaultFoodLocation: (Float, Float)) {
        super.init(color: UIColor.brown, image: #imageLiteral(resourceName: "Bunny"), food: FoodBag(defaultFoodLocation: defaultFoodLocation, image: #imageLiteral(resourceName: "Food Bag")))
    }
}
