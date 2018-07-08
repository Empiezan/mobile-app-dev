//
//  MovieDetailViewController.swift
//  MichaelChang-Lab4
//
//  Created by macos on 7/6/18.
//  Copyright © 2018 mc. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    var movieId : Int!
    var movieTitle : String!
    var posterPath : String!
    var releaseDate : String!
    var score : Int!
    
    
    @IBOutlet weak var movieTitleLabel: UINavigationItem!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setMovieDetails()
    }
    
    func setMovieDetails() {
        movieTitleLabel.title = movieTitle!
        let url = URL(string: "https://image.tmdb.org/t/p/w185\(posterPath!)")
        //TODO: try and catch safely
        let data = try! Data(contentsOf: url!)
        posterImageView.image = UIImage(data: data)
        releaseLabel.text = "Release Date: \(releaseDate!)"
        scoreLabel.text = "Score: \(score!)/100"
        getCertification()
    }
    
    func getCertification() {
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieId!)/release_dates?api_key=29689c3db85cc939c7b90bed28d5cb85")
        let data = try! Data(contentsOf: url!)
        let json = try! JSONDecoder().decode(TMDbDetailsResult.self, from: data)
        
        for locale in json.results {
            if "US" == locale.iso_3166_1 {
                ratingLabel.text = "Rating: \(locale.release_dates[0].certification!)"
            }
        }
    }
    
    @IBAction func addFavoriteMovie(_ sender: Any) {
//        print(movieTitle)
//        let path = Bundle.main.path(forResource: "Favorites", ofType: "plist")
//        print(path!)
//        movieTitle!.write(path!)
        
        let path = Bundle.main.path(forResource: "favorites", ofType: "db")
        let contactDB = FMDatabase(path: path)
        
        if !(contactDB.open()) {
            print("Unable to open database")
            return
        }
        else {
            do {
                try contactDB.executeUpdate("insert into favorites (movieTitle) values (?) ", values: [movieTitle])
            } catch let error as NSError {
                print("failed \(error)")
            }
        }
        
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
