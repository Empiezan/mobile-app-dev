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

import UIKit

class ViewController: UIViewController {
    
    enum Animal {
        case Dog
        case Cat
        case Bird
        case Bunny
        case Fish
    }
    
    var dog : Dog!
    var cat : Cat!
    var bird : Bird!
    var bunny : Bunny!
    var fish : Fish!
    var currentPet = Animal.Dog
    var foodBagLocation = CGPoint(x: 0, y: 0)
    var defaultBagLocation = CGPoint(x: 0, y: 0)
    
    @IBOutlet weak var happinessLevel: DisplayView!
    @IBOutlet weak var foodLevel: DisplayView!
    @IBOutlet weak var petBox: UIView!
    @IBOutlet weak var happinessLabel: UILabel!
    @IBOutlet weak var foodLevelLabel: UILabel!
    @IBOutlet weak var petImageView: UIImageView!
    @IBOutlet weak var foodBagView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setDefaultFoodPositions()
        petFunctionHelper(animal: currentPet, viewPet)
//        foodBagView.alpha = 0
//        foodBagView.isUserInteractionEnabled = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if foodBagView.isUserInteractionEnabled {
                foodBagLocation = touch.location(in: self.petBox)
                if foodBagView.frame.contains(foodBagLocation) {
                    foodBagView.center = foodBagLocation
                    petFunctionHelper(animal: currentPet, tryToEat)
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if foodBagView.isUserInteractionEnabled {
                foodBagLocation = touch.location(in: self.petBox)
                if foodBagView.frame.contains(foodBagLocation) && bagIsInPetBox() {
                    foodBagView.center = foodBagLocation
                        petFunctionHelper(animal: currentPet, tryToEat)
                }
            }
        }
    }
    
    func bagIsInPetBox() -> Bool {
        let halfBagWidth = foodBagView.frame.size.width / 2
        let halfBagHeight = foodBagView.frame.size.height / 2
        
        let bagTop = foodBagView.center.y - halfBagHeight
        let bagBottom = foodBagView.center.y + halfBagHeight
        let bagLeft = foodBagView.center.x - halfBagWidth
        let bagRight = foodBagView.center.x + halfBagWidth
        
        let petBoxTop : CGFloat = 0
        let petBoxBottom = foodBagView.center.y + halfBagHeight
        let petBoxLeft : CGFloat = 0
        let petBoxRight = petBox.center.x + halfBagWidth
        
//        let topLeftCorner = CGPoint(x: left, y: top)
//        let topRightCorner = CGPoint(x: right, y: top)
//        let bottomLeftCorner = CGPoint(x: left, y: bottom)
//        let bottomRightCorner = CGPoint(x: right, y: bottom)
        
        if bagTop <= petBoxTop {
            foodBagView.center.y += petBox.frame.size.height / 20
            return false
        }
        if bagBottom >= petBoxBottom {
            foodBagView.center.y -= petBox.frame.size.height / 20
            return false
        }
        if bagLeft <= petBoxLeft {
            foodBagView.center.x += petBox.frame.size.width / 20
            return false
        }
        if bagRight >= petBoxRight {
            foodBagView.center.x -= petBox.frame.size.width / 20
            return false
        }
        
        foodBagLocation = foodBagView.center
        
        return true
    }
    
    func tryToEat(pet : Pet) {
        if let petImage = petImageView.image {
            if distance(food : foodBagView.center, pet : petImageView.center) < petImage.size.width/3 && !pet.hasEaten {
                petFunctionHelper(animal: currentPet, { (pet: Pet) -> Void in
//                    pet.feed()
                    pet.eat()
                    foodLevelLabel.text = "fed: \(pet.getTimesFed())"
                    foodLevel.animateValue(to: pet.getFoodLevel())
                    foodBagView = pet.getFoodBag().setFoodBagView(view: foodBagView)
                })
            }
        }
    }
    
    func distance(food : CGPoint, pet : CGPoint) -> CGFloat {
        return sqrt(pow(pet.y - food.y, 2) + pow(pet.x - food.x, 2))
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
    
    func resetBagLocation(pet : Pet) {
        //combine hasbeenfed and buynewbag?
        pet.hasEaten = false
        foodBagView = pet.getFoodBag().buyNewBag(view: foodBagView)
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
//        if !pet.hasEaten {
            pet.getFoodBag().setFoodLocation(foodLocation: (Float(foodBagLocation.x)/Float(petBox.frame.width),Float(foodBagLocation.y)/Float(petBox.frame.height)))
//        }
    }
    
    func showFood(pet : Pet) {
        foodBagLocation = CGPoint(x: CGFloat(pet.getFoodBag().getFoodLocation().0) * petBox.frame.width, y: CGFloat(pet.getFoodBag().getFoodLocation().1) * petBox.frame.height)
        foodBagView = pet.getFoodBag().setFoodBagView(view: foodBagView)
//        print(pet.getFoodBag().isEmpty())
    }
    
    func setDefaultFoodPositions() {
        let xLocation = Float(abs(foodBagView.center.x) / petBox.frame.width)
        let yLocation = Float(abs(foodBagView.center.y) / petBox.frame.height)
        
        dog = Dog(defaultFoodLocation: (xLocation, yLocation))
        cat = Cat(defaultFoodLocation: (xLocation, yLocation))
        bird = Bird(defaultFoodLocation: (xLocation, yLocation))
        bunny = Bunny(defaultFoodLocation: (xLocation, yLocation))
        fish = Fish(defaultFoodLocation: (xLocation, yLocation))
    }
}
