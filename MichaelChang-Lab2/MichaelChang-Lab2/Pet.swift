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
    private var food : FoodBag
    private var image : UIImage
    private var color : UIColor
    private var happiness : Int
    private var foodLevel : Int
    private var timesFed : Int
    private var timesPlayed : Int
    private let stepValue : Int = 1
    var hasEaten = true
    
    private static let DEFAULT_HAPPINESS = 5
    private static let DEFAULT_FOOD_LEVEL = 5
    private static let DEFAULT_TIMES_FED = 0
    private static let DEFAULT_TIMES_PLAYED = 0
    
    init (color : UIColor, image: UIImage, food: FoodBag) {
        self.food = food
        self.image = image
        self.color = color
        self.happiness = Pet.DEFAULT_HAPPINESS
        self.foodLevel = Pet.DEFAULT_FOOD_LEVEL
        self.timesFed = Pet.DEFAULT_TIMES_FED
        self.timesPlayed = Pet.DEFAULT_TIMES_PLAYED
    }
    
    static func getDefaultFoodLocation() -> (Float, Float) {
        return FoodBag.getDefaultFoodLocation()
    }
    
    func getFoodBag() -> FoodBag {
        return food
    }
    
    func eat() {
        food.eatFromBag()
        timesFed += 1
        if foodLevel < 10 {
            foodLevel += stepValue
        }
        hasEaten = true
    }

    func feed() {
        hasEaten = false
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
