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
    private var happiness : CGFloat
    private var foodLevel : CGFloat
    private var timesFed : Int
    private var timesPlayed : Int
    private let stepValue : CGFloat = 0.1
    
    private static let DEFAULT_HAPPINESS : CGFloat = 0.5
    private static let DEFAULT_FOOD_LEVEL : CGFloat = 0.5
    private static let MAXIMUM_HAPPINESS : CGFloat = 1.0
    private static let MAXIMUM_FOOD_LEVEL : CGFloat = 1.0
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
    
    func getFoodBag() -> FoodBag {
        return food
    }
    
    func eat() {
        food.eatFromBag()
        timesFed += 1
        if foodLevel < Pet.MAXIMUM_FOOD_LEVEL {
            foodLevel += stepValue
        }
    }
    
    func play() {
        if foodLevel > 0 {
            timesPlayed += 1
            if happiness < Pet.MAXIMUM_HAPPINESS {
                happiness += stepValue
            }
            foodLevel -= stepValue
        }
    }
    
    func getImage() -> UIImage {
        return image
    }
    
    func getColor() -> UIColor {
        return color
    }
    
    func getHappiness() -> CGFloat {
        return happiness
    }
    
    func getFoodLevel() -> CGFloat {
        return foodLevel
    }
    
    func getTimesPlayed() -> Int {
        return timesPlayed
    }
    
    func getTimesFed() -> Int {
        return timesFed
    }
}
