//
//  FoodBag.swift
//  MichaelChang-Lab2
//
//  Created by labuser on 6/24/18.
//  Copyright © 2018 wustl. All rights reserved.
//
// Credits
// 1. How to index elements of a tuple (https://stackoverflow.com/questions/34573458/how-to-get-the-the-first-element-of-a-tuple-in-an-array-in-swift)

import Foundation
import UIKit

class FoodBag {
    private static var defaultFoodLocation : (Float, Float)!
    
    private var currentFoodLocation : (Float, Float)!
    private var eaten : Bool
    
    init(defaultFoodLocation : (Float, Float), image: UIImage) {
        FoodBag.defaultFoodLocation = defaultFoodLocation
        self.currentFoodLocation = defaultFoodLocation
        self.eaten = true
    }
    
    func isEmpty() -> Bool {
        return eaten
    }
    
    static func getDefaultFoodLocation() -> (Float, Float) {
        return defaultFoodLocation
    }
    
    func getFoodLocation() -> (Float, Float) {
        return currentFoodLocation
    }
    
    func setFoodLocation(foodLocation: (Float, Float)) {
        currentFoodLocation = foodLocation
    }

    func eatFromBag() {
        eaten = true
    }
    
    func buyNewBag() {
        eaten = false
    }
    
    func setFoodBagView(view : UIImageView) -> UIImageView {
        if let superView = view.superview {
            if eaten {
                view.alpha = 0
                view.isUserInteractionEnabled = false
                view.center = CGPoint(x: CGFloat(FoodBag.defaultFoodLocation.0) * superView.frame.width, y: CGFloat(FoodBag.defaultFoodLocation.1) * superView.frame.height)
            }
            else {
                view.alpha = 1
                view.isUserInteractionEnabled = true
                view.center = CGPoint(x: CGFloat(currentFoodLocation.0) * superView.frame.width, y: CGFloat(currentFoodLocation.1) * superView.frame.height)
            }
        }
        else {
            view.alpha = 0
            view.isUserInteractionEnabled = false
        }
        return view
    }
}
