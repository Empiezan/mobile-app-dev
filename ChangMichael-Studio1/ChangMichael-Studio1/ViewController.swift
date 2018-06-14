//
//  ViewController.swift
//  ChangMichael-Studio1
//
//  Created by labuser on 6/13/18.
//  Copyright © 2018 wustl. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var wuImage: UIImageView!
    
    @IBOutlet weak var slider: UISlider!
    
    @IBAction func Slider(_ sender: Any) {
        let rotateValue : CGFloat = Convert(sliderValue : slider.value);
        wuImage.transform = wuImage.transform.rotated(by: rotateValue);
        print(rotateValue);
    }
    
    func Convert(sliderValue: Float) -> CGFloat {
        return CGFloat(sliderValue * 2) * CGFloat.pi;
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

