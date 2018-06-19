//
//  ListViewController.swift
//  MichaelChang-Lab1
//
//  Created by macos on 6/17/18.
//  Copyright © 2018 cse438. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var cartItems : [String] = []
    var cartItemPrices : [Float] = []
    var cartTotal : Float = 0.0
    
    @IBOutlet weak var shoppingCartTable: UITableView!
    @IBOutlet weak var totalCartCost: UILabel!
    
    var calcController : ViewController!
    
    @IBAction func emptyCart(_ sender: Any) {
        cartItems.removeAll()
        cartItemPrices.removeAll()
        calcController.cartItems = cartItems
        calcController.cartItemPrices = cartItemPrices
        shoppingCartTable.reloadData()
        calculateCartTotal()
    }
    
    func calculateCartTotal () {
        cartTotal = 0.0
        for cartItemPrice in cartItemPrices {
            cartTotal += cartItemPrice
        }
        totalCartCost.text = String(format: "Total: $%.2f", cartTotal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewLoadSetup()
    }
    
    func viewLoadSetup(){
        if let foo = self.tabBarController?.viewControllers![0] as? ViewController {
            calcController = foo
            if let calcCartItems : [String] = foo.cartItems {
                cartItems = calcCartItems
                if let calcCartItemPrices : [Float] = foo.cartItemPrices {
                    cartItemPrices = calcCartItemPrices
                }
            }
        }
        if shoppingCartTable != nil {
            print("Reloading Cart Data")
            shoppingCartTable.reloadData()
        }
        else {
            print("Cart TableView is nil")
        }
        calculateCartTotal()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = shoppingCartTable.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = cartItems[indexPath.row]
        cell?.detailTextLabel?.text = "$\(cartItemPrices[indexPath.row])"
        return cell!
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle : UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            cartItems.remove(at: indexPath.row)
            cartItemPrices.remove(at: indexPath.row)
            calcController.cartItems = cartItems
            calcController.cartItemPrices = cartItemPrices
            shoppingCartTable.reloadData()
            calculateCartTotal()
        }
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
