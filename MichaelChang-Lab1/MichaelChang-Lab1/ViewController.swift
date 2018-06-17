//
//  ViewController.swift
//  MichaelChang-Lab1
//
//  Created by macos on 6/16/18.
//  Copyright © 2018 cse438. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var originalPrice: UITextField!
    @IBOutlet weak var discount: UITextField!
    @IBOutlet weak var salesTax: UITextField!
    @IBOutlet weak var finalPrice: UILabel!
    
    var p : Float = 0.0
    var d : Float = 0.0
    var t : Float = 0.0
    
    @IBAction func priceChanged(_ sender: Any) {
        if originalPrice.text == "" {
            p = 0.0;
        }
        else if let testVar = Float(originalPrice.text!) {
            p = testVar;
        }
        calculatePrice();
    }
    
    @IBAction func discountChanged(_ sender: Any) {
        if discount.text == "" {
            d = 0.0;
        }
        else if let testVar = Float(discount.text!) {
            d = testVar;
        }
        calculatePrice();
    }
    
    @IBAction func salesTaxChanged(_ sender: Any) {
        if salesTax.text == "" {
            t = 0.0;
        }
        else if let testVar = Float(salesTax.text!) {
            t = testVar;
        }
        calculatePrice();
    }
    
    func calculatePrice() {
        let priceAfterDiscount = p * (1 - d/100);
        let priceAfterTax = priceAfterDiscount * (1 + t/100);
        finalPrice.text = "$\(String(format: "%.2f", priceAfterTax))";
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

