//
//  ViewController.swift
//  MichaelChang-Lab2
//
//  Created by labuser on 6/22/18.
//  Copyright © 2018 wustl. All rights reserved.
//

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
    
    @IBOutlet weak var happinessLevel: DisplayView!
    @IBOutlet weak var foodLevel: DisplayView!
    @IBOutlet weak var petBox: UIView!
    @IBOutlet weak var happinessLabel: UILabel!
    @IBOutlet weak var foodLevelLabel: UILabel!
    @IBOutlet weak var petImage: UIImageView!
    
    
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
        petFunctionHelper(animal: currentPet, { (pet: Pet) -> Void in
            pet.feed()
            foodLevelLabel.text = "fed: \(pet.getTimesFed())"
            foodLevel.animateValue(to: pet.getFoodLevel())
        })
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
        petImage.image = pet.getImage()
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

