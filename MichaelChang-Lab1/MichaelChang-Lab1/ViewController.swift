//
//  ViewController.swift
//  MichaelChang-Lab1
//
//  Created by macos on 6/16/18.
//  Copyright © 2018 cse438. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var itemName: UITextField!
    @IBOutlet weak var originalPrice: UITextField!
    @IBOutlet weak var discount: UITextField!
    @IBOutlet weak var salesTax: UITextField!
    @IBOutlet weak var finalPrice: UILabel!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var amount: UITextField!

//    var p : Float = 0.0
//    var d : Float = 0.0
//    var t : Float = 0.0
//    var a : Float = 1.0
//    var finalP : Float = 0.0
    
    var cartItems : [String] = []
    var cartItemAmounts : [Float] = []
    var cartItemPrices : [Float] = []
    
    lazy var itemNameValid = createValidation(field: itemName, defaultValue: nil)
    lazy var priceValid = createValidation(field: originalPrice, defaultValue: 0)
    lazy var discountValid = createValidation(field: discount, defaultValue: 0)
    lazy var taxValid = createValidation(field: salesTax, defaultValue: 0)
    lazy var amountValid = createValidation(field: amount, defaultValue: 1)
    
    enum Error {
        case nonNegativeError
        case nonNumberError
        case numberError
        case excessiveDiscountError
        case invalidAmountError
        case noItemNameError
    }
    
    func showError(err : Error) {
        errorMessage.isHidden = false
        if err == Error.nonNegativeError {
            errorMessage.text = "Error: Non-Negative Numbers Only"
        }
        else if err == Error.nonNumberError {
            errorMessage.text = "Error: Numbers Only"
        }
        else if err == Error.numberError {
            errorMessage.text = "Error: Item Name Cannot Be Only Numeric"
        }
        else if err == Error.excessiveDiscountError {
            errorMessage.text = "Error: Discount Cannot Exceed 100%"
        }
        else if err == Error.invalidAmountError {
            errorMessage.text = "Error: Amount Must Be Greater Than 0"
        }
        else if err == Error.noItemNameError {
            errorMessage.text = "Error: Item Name Must Not Be Blank"
        }
    }
    
    func createValidation(field : UITextField!, defaultValue : Float!) -> () -> Bool {
        func validateField () -> Bool {
            let fieldText = field.text!
            if field.isEqual(itemName) {
                if fieldText == "" {
                    showError(err: Error.noItemNameError)
                    return false
                }
                else if !CharacterSet.letters.contains(fieldText.unicodeScalars.first!) {
                    showError(err: Error.numberError)
                    return false
                }
            }
            else {
                if let fieldNum = Float(field.text!) {
                    if fieldNum < 0 {
                        showError(err: Error.nonNegativeError)
                        return false
                    }
                    if field.isEqual(amount) && fieldNum <= 0 {
                        showError(err: Error.invalidAmountError)
                        return false
                    }
                    if field.isEqual(discount) && fieldNum > 100 {
                        showError(err: Error.excessiveDiscountError)
                        return false
                    }
                }
                else {
                    if fieldText != "" {
                        showError(err: Error.nonNumberError)
                        return false
                    }
                }
            }
            errorMessage.isHidden = true
            return true
        }
        return validateField
    }
    
    @IBAction func priceChanged(_ sender: Any) {
        if priceValid() {
            print("Valid Price")
            calculatePrice()
        }
        else {
            print("Invalid Price")
        }
    }
    
    @IBAction func discountChanged(_ sender: Any) {
        if discountValid() {
            calculatePrice();
        }
    }
    
    @IBAction func salesTaxChanged(_ sender: Any) {
        if taxValid() {
            calculatePrice()
        }
    }
    
    @IBAction func amountChanged(_ sender: Any) {
        if amountValid() {
            calculatePrice()
        }
    }
    
    func checkBlankFields() -> [Float] {
        var fields : [Float] = [0, 0, 0, 1]
        if originalPrice.text! != "" {
            fields[0] = Float(originalPrice.text!)!
        }
        if discount.text! != "" {
            fields[1] = Float(discount.text!)!
        }
        if salesTax.text! != "" {
            fields[2] = Float(salesTax.text!)!
        }
        if amount.text! != "" {
            fields[3] = Float(amount.text!)!
        }
        return fields
    }
    
    func calculatePrice() {
        var fields : [Float] = checkBlankFields()
        let priceAfterDiscount = fields[0] * (1 - fields[1]/100)
        let priceAfterTax = priceAfterDiscount * (1 + fields[2]/100)
        let finalP = priceAfterTax * fields[3]
        finalPrice.text = "$\(String(format: "%.2f", finalP))"
    }
    
    @IBAction func addToCart(_ sender: Any) {
        let fieldsValid = itemNameValid() && priceValid() && discountValid() && taxValid()
        if fieldsValid {
            cartItems.append(itemName.text!)
            var a : Float = 0
            if amount.text! != "" {
                a = Float(amount.text!)!
            }
            for item in cartItems {
                print(item)
            }
            if cartItems.contains(itemName.text!) {
                print("Cart already contains " + itemName.text!)
                let itemIndex = cartItems.index(of: itemName.text!)
                cartItemAmounts[itemIndex!] += a
                cartItemPrices[itemIndex!] += Float(finalPrice.text!)!
            }
            else {
                print("Cart adding new item " + itemName.text!)
                cartItems.append(itemName.text!)
                cartItemAmounts.append(a)
                cartItemPrices.append(Float(finalPrice.text!)!)
            }
            let itemPrice : String = String(String.dropFirst(finalPrice.text!)())
            cartItemPrices.append(Float(itemPrice)!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        errorMessage.isHidden = true;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
