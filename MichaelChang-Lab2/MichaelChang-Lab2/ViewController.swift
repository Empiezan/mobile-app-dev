//
//  ViewController.swift
//  MichaelChang-Lab2
//
//  Created by labuser on 6/22/18.
//  Copyright © 2018 wustl. All rights reserved.
//
// Credits
// 1. Food bag image from OpenClipart-Vectors (https://pixabay.com/en/vegetables-paper-bag-carrots-576881/)
// 2. Learned how to move images around the screen from "How to Make an Image Move with Touch (Swift in Xcode)" (https://www.youtube.com/watch?v=4D2KNOFtowQ). Specifically, from a comment from user "Bored Person" who provided an update to the code from the video for Swift 4.
// 3. Learned how to keep a UIImageView from going outside of a UIView from a Stack Overflow answer (https://stackoverflow.com/questions/41091551/preventing-draggable-view-to-go-off-screen).

import UIKit

class ViewController: UIViewController {
    
    enum Animal {
        case Dog
        case Cat
        case Bird
        case Bunny
        case Fish
    }
    
    var dog : Dog = Dog()
    var cat : Cat = Cat()
    var bird : Bird = Bird()
    var bunny : Bunny = Bunny()
    var fish : Fish = Fish()
    var currentPet = Animal.Dog
    
    var foodBagLocation = CGPoint(x: 0, y: 0)
    
    @IBOutlet weak var happinessLevel: DisplayView!
    @IBOutlet weak var foodLevel: DisplayView!
    @IBOutlet weak var petBox: UIView!
    @IBOutlet weak var happinessLabel: UILabel!
    @IBOutlet weak var foodLevelLabel: UILabel!
    @IBOutlet weak var petImageView: UIImageView!
    @IBOutlet weak var foodBagView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDefaultFoodPosition()
        petFunctionHelper(animal: currentPet, viewPet)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setDefaultFoodPosition() {
        let xLocation = Float(abs(foodBagView.center.x) / petBox.frame.width)
        let yLocation = Float(abs(foodBagView.center.y) / petBox.frame.height)
        FoodBag.setDefaultFoodLocation(newLocation: (xLocation, yLocation))
    }
    
    func petFunctionHelper(animal : Animal, _ f : (Pet) -> Void) {
        switch(animal) {
        case .Dog:
            f(dog)
        case .Cat:
            f(cat)
        case .Bird:
            f(bird)
        case .Bunny:
            f(bunny)
        case .Fish:
            f(fish)
        }
    }
    
    func resetBagLocation(pet : Pet) {
        foodBagView = pet.getFoodBag().buyNewBag(view: foodBagView)
    }
    
    func showFood(pet : Pet) {
        foodBagLocation = CGPoint(x: CGFloat(pet.getFoodBag().getFoodLocation().0) * petBox.frame.width, y: CGFloat(pet.getFoodBag().getFoodLocation().1) * petBox.frame.height)
        foodBagView = pet.getFoodBag().setFoodBagView(view: foodBagView)
    }
    
    func keepBagInBox(x : CGFloat, y : CGFloat) {
        let halfBagWidth = foodBagView.frame.size.width / 2
        let halfBagHeight = foodBagView.frame.size.height / 2
        let petBoxWidth = petBox.frame.size.width
        let petBoxHeight = petBox.frame.size.height
        
        var correctedX = max(halfBagWidth, x)
        correctedX = min(correctedX, petBoxWidth - halfBagWidth)
        var correctedY = max(halfBagHeight, y)
        correctedY = min(correctedY, petBoxHeight - halfBagHeight)
        
        foodBagLocation.x = correctedX
        foodBagLocation.y = correctedY
        
        foodBagView.center = foodBagLocation
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if foodBagView.isUserInteractionEnabled {
                foodBagLocation = touch.location(in: self.petBox)
                if foodBagView.frame.contains(foodBagLocation) {
                    let x = touch.location(in: self.petBox).x
                    let y = touch.location(in: self.petBox).y
                    keepBagInBox(x: x, y: y)
                    foodBagView.center = foodBagLocation
                    petFunctionHelper(animal: currentPet, tryToEat)
                }
            }
        }
    }
    
    func distance(food : CGPoint, pet : CGPoint) -> CGFloat {
        return sqrt(pow(pet.y - food.y, 2) + pow(pet.x - food.x, 2))
    }
    
    func tryToEat(pet : Pet) {
        if let petImage = petImageView.image {
            if distance(food : foodBagView.center, pet : petImageView.center) < (1.0/3) * petImage.size.height && !pet.getFoodBag().isEmpty() {
                petFunctionHelper(animal: currentPet, { (pet: Pet) -> Void in
                    if !pet.isFull() {
                        pet.eat()
                        foodLevelLabel.text = "fed: \(pet.getTimesFed())"
                        foodLevel.animateValue(to: pet.getFoodLevel())
                        foodBagView = pet.getFoodBag().setFoodBagView(view: foodBagView)
                    }
                })
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if foodBagView.isUserInteractionEnabled {
                foodBagLocation = touch.location(in: self.petBox)
                if foodBagView.frame.contains(foodBagLocation) {
                    let x = touch.location(in: self.petBox).x
                    let y = touch.location(in: self.petBox).y
                    keepBagInBox(x: x, y: y)
                    foodBagView.center = foodBagLocation
                        petFunctionHelper(animal: currentPet, tryToEat)
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let x = touch.location(in: self.petBox).x
            let y = touch.location(in: self.petBox).y
            if foodBagView.frame.contains(CGPoint(x: x, y: y)) {
                keepBagInBox(x: x, y: y)
            }
            petFunctionHelper(animal: currentPet, tryToEat)
        }
    }
    
    func viewPet(pet : Pet) {
        petFunctionHelper(animal: currentPet, showFood)
        petImageView.image = pet.getImage()
        petBox.backgroundColor = pet.getColor()
        happinessLevel.color = pet.getColor()
        foodLevel.color = pet.getColor()
        happinessLevel.animateValue(to: pet.getHappiness())
        foodLevel.animateValue(to: pet.getFoodLevel())
        happinessLabel.text = "played: \(pet.getTimesPlayed())"
        foodLevelLabel.text = "fed: \(pet.getTimesFed())"
    }
    
    func recordFoodLocation(pet : Pet) {
        pet.getFoodBag().setFoodLocation(foodLocation: (Float(foodBagLocation.x)/Float(petBox.frame.width),Float(foodBagLocation.y)/Float(petBox.frame.height)))
    }
    
    @IBAction func fishButtonPressed(_ sender: Any) {
        petFunctionHelper(animal: currentPet, recordFoodLocation)
        currentPet = .Fish
        petFunctionHelper(animal: .Fish, viewPet)
    }
    
    @IBAction func bunnyButtonPressed(_ sender: Any) {
        petFunctionHelper(animal: currentPet, recordFoodLocation)
        currentPet = .Bunny
        petFunctionHelper(animal: .Bunny, viewPet)
    }
    
    @IBAction func birdButtonPressed(_ sender: Any) {
        petFunctionHelper(animal: currentPet, recordFoodLocation)
        currentPet = .Bird
        petFunctionHelper(animal: .Bird, viewPet)
    }
    
    @IBAction func catButtonPressed(_ sender: Any) {
        petFunctionHelper(animal: currentPet, recordFoodLocation)
        currentPet = .Cat
        petFunctionHelper(animal: .Cat, viewPet)
    }
    
    @IBAction func dogButtonPressed(_ sender: Any) {
        petFunctionHelper(animal: currentPet, recordFoodLocation)
        currentPet = .Dog
        petFunctionHelper(animal: .Dog, viewPet)
    }
    
    @IBAction func playButtonPressed(_ sender: Any) {
        petFunctionHelper(animal: currentPet, { (pet: Pet) -> Void in
            pet.play()
            happinessLabel.text = "played: \(pet.getTimesPlayed())"
            happinessLevel.animateValue(to: pet.getHappiness())
            foodLevel.animateValue(to: pet.getFoodLevel())
        })
    }
    
    @IBAction func feedButtonPressed(_ sender: Any) {
        petFunctionHelper(animal: currentPet, resetBagLocation)
    }
}
