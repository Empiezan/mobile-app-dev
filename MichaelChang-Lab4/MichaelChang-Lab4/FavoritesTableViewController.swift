//
//  FavoritesTableViewController.swift
//  MichaelChang-Lab4
//
//  Created by macos on 7/7/18.
//  Copyright © 2018 mc. All rights reserved.
//

import UIKit

class FavoritesTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var pListPath : String!
    var favorites : [String] = []
    
    @IBOutlet weak var favoritesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getFavorites()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getFavorites()
        favoritesTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getFavorites() {
//        pListPath = Bundle.main.path(forResource: "Favorites", ofType: "plist")
//        favorites = NSArray(contentsOfFile: pListPath!)! as! Array<String>
        favorites.removeAll()
        let path = Bundle.main.path(forResource: "favorites", ofType: "db")
        let contactDB = FMDatabase(path: path)
        
        if !(contactDB.open()) {
            print("Unable to open database")
            return
        }
        else {
            do {
                let results = try contactDB.executeQuery("select * from favorites", values: nil)
                while(results.next()) {
                    let title = results.string(forColumn: "movieTitle")
                    favorites.append(title!)
                }
            } catch let error as NSError {
                print("failed \(error)")
            }
        }
        
        favoritesTableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return favorites.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteMovie", for: indexPath)
        cell.textLabel?.text = favorites[indexPath.row]
        // Configure the cell...

        return cell
    }
 
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            let removedMovie = favorites[indexPath.row]
            let path = Bundle.main.path(forResource: "favorites", ofType: "db")
            let contactDB = FMDatabase(path: path)
            
            if !(contactDB.open()) {
                print("Unable to open database")
                return
            }
            else {
                do {
                    try contactDB.executeUpdate("DELETE FROM favorites WHERE movieTitle=?", values: [removedMovie])
                } catch let error as NSError {
                    print("failed \(error)")
                }
            }
            favorites.remove(at: indexPath.row)
            favoritesTableView.reloadData()
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
