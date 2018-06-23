//
//  ViewController.swift
//  MichaelChang-Lab2
//
//  Created by labuser on 6/22/18.
//  Copyright © 2018 wustl. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var happinessLevel: DisplayView!
    @IBOutlet weak var foodLevel: DisplayView!
    @IBOutlet weak var petBox: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        happinessLevel.color = UIColor.cyan
        foodLevel.color = UIColor.cyan
        happinessLevel.animateValue(to: 0.87)
        foodLevel.animateValue(to: 0.22)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

