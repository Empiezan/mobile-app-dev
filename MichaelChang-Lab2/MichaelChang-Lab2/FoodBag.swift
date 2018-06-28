//
//  FoodBag.swift
//  MichaelChang-Lab2
//
//  Created by labuser on 6/24/18.
//  Copyright © 2018 wustl. All rights reserved.
//
// Credits
// 1. How to postpone the setting of a static variable (https://stackoverflow.com/questions/38164270/define-a-static-variable-in-swift)

import Foundation
import UIKit

class FoodBag {
    
    static var defaultLocationPlaceholder : (Float, Float) = (50,50)
    static var defaultFoodLocation : (Float, Float) {
        get {
            return defaultLocationPlaceholder
        }
    }
    private var currentFoodLocation : (Float, Float) = (50,50)
    private var eaten : Bool
    
    init(image: UIImage) {
        self.currentFoodLocation = FoodBag.defaultFoodLocation
        self.eaten = true
    }
    
    func isEmpty() -> Bool {
        return eaten
    }
    
    static func getDefaultFoodLocation() -> (Float, Float) {
        return defaultFoodLocation
    }
    
    static func setDefaultFoodLocation(newLocation : (Float, Float)) {
        defaultLocationPlaceholder = newLocation
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
    
    func buyNewBag(view : UIImageView) -> UIImageView {
        eaten = false
        if let superView = view.superview {
            view.alpha = 1
            view.isUserInteractionEnabled = true
            view.center = CGPoint(x: CGFloat(FoodBag.defaultFoodLocation.0) * superView.frame.width, y: CGFloat(FoodBag.defaultFoodLocation.1) * superView.frame.height)
        }
        return view
    }
    
    func setFoodBagView(view : UIImageView) -> UIImageView {
        if let superView = view.superview {
            if eaten {
                view.alpha = 0
            }
            else {
                view.alpha = 1
                view.isUserInteractionEnabled = true
                view.center = CGPoint(x: CGFloat(currentFoodLocation.0) * superView.frame.width, y: CGFloat(currentFoodLocation.1) * superView.frame.height)
            }
        }
        return view
    }
}
