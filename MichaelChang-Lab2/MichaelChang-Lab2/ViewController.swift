//
//  ViewController.swift
//  MichaelChang-Lab2
//
//  Created by labuser on 6/22/18.
//  Copyright © 2018 wustl. All rights reserved.
//
// Credits
// 1. Food bag image from OpenClipart-Vectors (https://pixabay.com/en/vegetables-paper-bag-carrots-576881/)
// 2. Learned how to move images around the screen from "How to Make an Image Move with Touch (Swift in Xcode)" (https://www.youtube.com/watch?v=4D2KNOFtowQ). Specifically, from a comment from user "Bored Person" who provided an update to the code from the video for the latest version of Swift.
// 3. Learned how to make a delay in Swift from Stack Overflow (https://stackoverflow.com/questions/38031137/how-to-program-a-delay-in-swift-3)

import UIKit

class ViewController: UIViewController {
    
    enum Animal {
        case Dog
        case Cat
        case Bird
        case Bunny
        case Fish
    }
    
    let dog = Dog()
    let cat = Cat()
    let bird = Bird()
    let bunny = Bunny()
    let fish = Fish()
    var currentPet = Animal.Dog
    var foodBagLocation = CGPoint(x: 0, y: 0)
    var defaultBagLocation = CGPoint(x: 0, y: 0)
    var hasFed = true
    
    @IBOutlet weak var happinessLevel: DisplayView!
    @IBOutlet weak var foodLevel: DisplayView!
    @IBOutlet weak var petBox: UIView!
    @IBOutlet weak var happinessLabel: UILabel!
    @IBOutlet weak var foodLevelLabel: UILabel!
    @IBOutlet weak var petImageView: UIImageView!
    @IBOutlet weak var foodBagView: UIImageView!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if foodBagView.isUserInteractionEnabled {
                foodBagLocation = touch.location(in: self.petBox)
                foodBagView.center = foodBagLocation
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if foodBagView.isUserInteractionEnabled {
                foodBagLocation = touch.location(in: self.petBox)
                foodBagView.center = foodBagLocation
                if let petImage = petImageView.image {
                    if distance(food : foodBagView.center, pet : petImageView.center) < petImage.size.width/3 && !hasFed {
                        petFunctionHelper(animal: currentPet, { (pet: Pet) -> Void in
                            hasFed = true
                            foodBagView.alpha = 0
                            foodBagView.isUserInteractionEnabled = false
                            pet.feed()
                            foodLevelLabel.text = "fed: \(pet.getTimesFed())"
                            foodLevel.animateValue(to: pet.getFoodLevel())
                        })
                    }
                }
            }
        }
    }
    
    func checkEating(timeStamp : Date) {
        print("pet: \(petImageView.center)")
        print("food: \(foodBagView.center)")
        print("distance: \(distance(food: foodBagView.center, pet: petImageView.center))")
    }
    
    func distance(food : CGPoint, pet : CGPoint) -> CGFloat {
        return sqrt(pow(pet.y - food.y, 2) + pow(pet.x - food.x, 2))
    }
    
    @IBAction func fishButtonPressed(_ sender: Any) {
        currentPet = .Fish
        petFunctionHelper(animal: .Fish, viewPet)
    }
    
    @IBAction func bunnyButtonPressed(_ sender: Any) {
        currentPet = .Bunny
        petFunctionHelper(animal: .Bunny, viewPet)
    }
    
    @IBAction func birdButtonPressed(_ sender: Any) {
        currentPet = .Bird
        petFunctionHelper(animal: .Bird, viewPet)
    }
    
    @IBAction func catButtonPressed(_ sender: Any) {
        currentPet = .Cat
        petFunctionHelper(animal: .Cat, viewPet)
    }
    
    @IBAction func dogButtonPressed(_ sender: Any) {
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
        foodBagView.isUserInteractionEnabled = true
        foodBagView.center = defaultBagLocation
        foodBagView.alpha = 1
        hasFed = false
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
        petImageView.image = pet.getImage()
        petBox.backgroundColor = pet.getColor()
        happinessLevel.color = pet.getColor()
        foodLevel.color = pet.getColor()
        happinessLevel.animateValue(to: pet.getHappiness())
        foodLevel.animateValue(to: pet.getFoodLevel())
        happinessLabel.text = "played: \(pet.getTimesPlayed())"
        foodLevelLabel.text = "fed: \(pet.getTimesFed())"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        petFunctionHelper(animal: currentPet, viewPet)
        defaultBagLocation = foodBagView.center;
        foodBagView.alpha = 0
        foodBagView.isUserInteractionEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

