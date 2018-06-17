//
//  SecondViewController.swift
//  MichaelChang-Lab1
//
//  Created by macos on 6/16/18.
//  Copyright © 2018 cse438. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var originalPrice: UITextField!
    @IBOutlet weak var discount: UITextField!
    @IBOutlet weak var salesTax: UITextField!
    @IBOutlet weak var finalPrice: UILabel!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var amount: UITextField!
    
    
    var p : Float = 0.0
    var d : Float = 0.0
    var t : Float = 0.0
    var a : Float = 1.0

    let nonNegativeError = "Error: Non-Negative Numbers Only"
    let nonNumberError = "Error: Numbers Only"
    
    @IBAction func priceChanged(_ sender: Any) {
        if originalPrice.text == "" {
            errorMessage.isHidden = true;
            p = 0.0;
        }
        else if let testVar = Float(originalPrice.text!) {
            if testVar >= 0 {
                errorMessage.isHidden = true;
                p = testVar;
            } else {
                errorMessage.isHidden = false;
                errorMessage.text = nonNegativeError;
            }
        }
        else {
            errorMessage.isHidden = false;
            errorMessage.text = nonNumberError;
        }
        calculatePrice();
    }

    @IBAction func discountChanged(_ sender: Any) {
        if discount.text == "" {
            errorMessage.isHidden = true;
            d = 0.0;
        }
        else if let testVar = Float(discount.text!) {
            if testVar >= 0 {
                errorMessage.isHidden = true;
                d = testVar;
            } else {
                errorMessage.isHidden = false;
                errorMessage.text = nonNegativeError;
            }
        }
        else {
            errorMessage.isHidden = false;
            errorMessage.text = nonNumberError;
        }
        calculatePrice();
    }

    @IBAction func salesTaxChanged(_ sender: Any) {
        if salesTax.text == "" {
            errorMessage.isHidden = true;
            t = 0.0;
        }
        else if let testVar = Float(salesTax.text!) {
            if testVar >= 0 {
                errorMessage.isHidden = true;
                t = testVar;
            } else {
                errorMessage.isHidden = false;
                errorMessage.text = nonNegativeError;
            }
        }
        else {
            errorMessage.isHidden = false;
            errorMessage.text = nonNumberError;
        }
        calculatePrice();
    }

    @IBAction func amountChanged(_ sender: Any) {
        if amount.text == "" {
            errorMessage.isHidden = true;
            a = 0.0;
        }
        else if let testVar = Float(amount.text!) {
            if testVar >= 0 {
                errorMessage.isHidden = true;
                a = testVar;
            } else {
                errorMessage.isHidden = false;
                errorMessage.text = nonNegativeError;
            }
        }
        else {
            errorMessage.isHidden = false;
            errorMessage.text = nonNumberError;
        }
        calculatePrice();
    }
    
    func calculatePrice() {
        let priceAfterDiscount = p * (1 - d/100);
        let priceAfterTax = priceAfterDiscount * (1 + t/100);
        let pricePerItem = priceAfterTax / a;
        finalPrice.text = "$\(String(format: "%.2f / item", pricePerItem))";
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        errorMessage.isHidden = true;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    

}
