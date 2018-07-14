//
//  GenreViewController.swift
//  MichaelChang-Lab4
//
//  Created by labuser on 7/14/18.
//  Copyright © 2018 mc. All rights reserved.
//

import UIKit

class GenreViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var genres : [Genre]!
    var currGenre : Genre = Genre(id: 0, name: "All")
    
    @IBOutlet weak var genreTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print(currGenre.name)
//        let movieVC = ViewController(nibName: nil, bundle: nil)
//        movieVC.currGenre = currGenre
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genres.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = genreTableView.dequeueReusableCell(withIdentifier: "genre", for: indexPath)
        cell.textLabel?.text = genres[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currGenre = genres[indexPath.row]
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        print(currGenre)
//        if let movieVC = segue.destination as? ViewController {
//            movieVC.currGenre = currGenre
//        }
    }
 

}
