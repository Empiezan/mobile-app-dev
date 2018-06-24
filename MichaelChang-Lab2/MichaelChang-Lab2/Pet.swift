//
//  Pet.swift
//  MichaelChang-Lab2
//
//  Created by labuser on 6/23/18.
//  Copyright © 2018 wustl. All rights reserved.
//

import Foundation
import UIKit

class Pet {
    private var food = FoodBag()
    private var image : UIImage
    private var color : UIColor
    private var happiness : Int
    private var foodLevel : Int
    private var timesFed : Int
    private var timesPlayed : Int
    private let stepValue : Int = 1
    
    init (color : UIColor, image: UIImage) {
        self.image = image
        self.color = color
        self.happiness = 5
        self.foodLevel = 5
        self.timesFed = 0
        self.timesPlayed = 0
    }
    
    func getFoodBag() -> FoodBag {
        return food
    }
    
    func eat() {
        food.eatFromBag()
    }

    func feed() {
        timesFed += 1
        if foodLevel < 10 {
            foodLevel += stepValue
        }
    }
    
    func play() {
        if foodLevel > 0 {
            timesPlayed += 1
            if happiness < 10 {
                happiness += stepValue
            }
            foodLevel -= stepValue
        }
        print(foodLevel)
        print(happiness)
    }
    
    func getImage() -> UIImage {
        //how to safely unwrap this?
        return image
    }
    
    func getColor() -> UIColor {
        return color
    }
    
    func getHappiness() -> CGFloat {
        return CGFloat(Float(happiness)/10)
    }
    
    func getFoodLevel() -> CGFloat {
        return CGFloat(Float(foodLevel)/10)
    }
    
    func getTimesPlayed() -> Int {
        return timesPlayed
    }
    
    func getTimesFed() -> Int {
        return timesFed
    }
}
