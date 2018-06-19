//
//  ViewController.swift
//  MichaelChang-Lab1
//
//  Created by macos on 6/16/18.
//  Copyright © 2018 cse438. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var itemName: UITextField!
    @IBOutlet weak var originalPrice: UITextField!
    @IBOutlet weak var discount: UITextField!
    @IBOutlet weak var salesTax: UITextField!
    @IBOutlet weak var finalPrice: UILabel!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var amount: UITextField!
    @IBOutlet weak var shoppingCartTable: UITableView!
    @IBOutlet weak var cartTotal: UILabel!
    @IBOutlet weak var shoppingCartIcon: UIButton!
    @IBOutlet weak var emptyCartButton: UIButton!
    
    var p : Float = 0.0
    var d : Float = 0.0
    var t : Float = 0.0
    var a : Float = 1.0
    var finalP : Float = 0.0
    var cartTotalCost : Float = 0.0
    
    var cartItemAmounts : [Float] = []
    var cartItems : [String] = []
    var cartItemPrices : [Float] = []
    
    let nonNegativeError = "Error: Non-Negative Numbers Only"
    let nonNumberError = "Error: Numbers Only"
    let itemNameMissingError = "Error: Item Name is Required"
    
    @IBAction func emptyCart(_ sender: Any) {
        cartItems.removeAll()
        cartItemAmounts.removeAll()
        cartItemPrices.removeAll()
        shoppingCartTable.reloadData()
        calculateCartTotal()
    }
    
    func calculateCartTotal () {
        cartTotalCost = 0.0
        for cartItemPrice in cartItemPrices {
            cartTotalCost += cartItemPrice
        }
        cartTotal.text = String(format: "Total: $%.2f", cartTotalCost)
    }
    
    @IBAction func cartIconPressed(_ sender: Any) {
        shoppingCartTable.isHidden = !shoppingCartTable.isHidden
        cartTotal.isHidden = !cartTotal.isHidden
        emptyCartButton.isHidden = !emptyCartButton.isHidden
        shoppingCartTable.reloadData()
        calculateCartTotal()
    }
    
    @IBAction func addToCart(_ sender: Any) {
        if itemName.text! == "" {
            errorMessage.isHidden = false
            errorMessage.text = itemNameMissingError
            return
        }
        errorMessage.isHidden = true
        if cartItems.contains(itemName.text!) {
            print("Cart already contains " + itemName.text!)
            let itemIndex = cartItems.index(of: itemName.text!)
            cartItemAmounts[itemIndex!] += a
            cartItemPrices[itemIndex!] += finalP
        }
        else {
            print("Cart adding new item " + itemName.text!)
            cartItemAmounts.append(a)
            cartItems.append(itemName.text!)
            cartItemPrices.append(Float(finalP))
        }
    }
    
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
            }
            else {
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
            a = 1.0;
        }
        else if let testVar = Float(amount.text!) {
            if testVar >= 0 {
                errorMessage.isHidden = true;
                a = testVar;
            }
            else {
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
        finalP = priceAfterTax * a;
//        print("Number of view controllers = \(self.tabBarController?.viewControllers?.count)")
//        if let foo = self.tabBarController?.viewControllers![1] as? SecondViewController {
//            print("Found second view controller" + foo.test)
//            if let textLabel : UILabel = foo.finalPrice {
//                print("Found reference to final price label")
//                if let str : String = textLabel.text {
//                    print("yayyyyy" + str)
//                }
//            }
//        } else {
//            print("Could not get reference to Second View Controller")
//        }
        finalPrice.text = "$\(String(format: "%.2f", finalP))";
//        print(secondViewController.finalPrice.text)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        errorMessage.isHidden = true;
        shoppingCartTable.isHidden = true;
        cartTotal.isHidden = true;
        emptyCartButton.isHidden = true;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = shoppingCartTable.dequeueReusableCell(withIdentifier: "cartItem")
        cell?.textLabel?.text = String(format: "%.2f", cartItemAmounts[indexPath.row]) + " " + cartItems[indexPath.row]
        cell?.detailTextLabel?.text = String(format: "%.2f", cartItemPrices[indexPath.row])
        return cell!
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle : UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            cartItems.remove(at: indexPath.row)
            cartItemAmounts.remove(at: indexPath.row)
            cartItemPrices.remove(at: indexPath.row)
            shoppingCartTable.reloadData()
            calculateCartTotal()
        }
    }
}
