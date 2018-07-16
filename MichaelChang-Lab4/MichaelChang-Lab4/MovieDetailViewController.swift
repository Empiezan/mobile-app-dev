//
//  MovieDetailViewController.swift
//  MichaelChang-Lab4
//
//  Created by macos on 7/6/18.
//  Copyright © 2018 mc. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    var movie : MovieData!
    
    @IBOutlet weak var movieTitleLabel: UINavigationItem!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var addToFavorites: UIButton!
    
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
        checkFavorites()
    }
    
    func checkFavorites() {
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
                    if title == movie.title {
                        addToFavorites.isHidden = true
                    }
                }
            } catch let error as NSError {
                print("failed \(error)")
            }
        }
    }
    
    func setMovieDetails() {
        movieTitleLabel.title = movie.title
        releaseLabel.text = "Release: \(movie.release_date)"
        scoreLabel.text = "Score: \(Int(movie.vote_average * 10))/100"

        DispatchQueue.global().async {
            do {
                let cert = self.getCertification()
                let url = URL(string: "https://image.tmdb.org/t/p/w185\(self.movie.poster_path!)")
                let data = try Data(contentsOf: url!)
                DispatchQueue.main.async {
                    if cert != nil {
                        self.ratingLabel.text = "Rating: \(cert!)"
                    }
                    self.posterImageView.image = UIImage(data: data)
                }
            } catch let error as NSError {
                print(error)
            }
        }
    }
    
    func getCertification() -> String? {
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movie.id!)/release_dates?api_key=29689c3db85cc939c7b90bed28d5cb85")
        var data : Data!
        while data == nil {
            data = try? Data(contentsOf: url!)
        }
        let json = try! JSONDecoder().decode(TMDbDetailsResult.self, from: data)
        
        for locale in json.results {
            if "US" == locale.iso_3166_1 {
                if locale.release_dates[0].certification! == ""{
                    return "N/A"
                }
                else {
                    return locale.release_dates[0].certification!
                }
            }
        }
        return "N/A"
    }
    
    @IBAction func addFavoriteMovie(_ sender: Any) {
        let path = Bundle.main.path(forResource: "favorites", ofType: "db")
        let contactDB = FMDatabase(path: path)
        
        if !(contactDB.open()) {
            print("Unable to open database")
            return
        }
        else {
            do {
                try contactDB.executeUpdate("insert into favorites (movieTitle, movieId, poster_path, release_date, score) values (?,?,?,?,?) ", values: [movie.title, movie.id, movie.poster_path!, movie.release_date, movie.vote_average])
            } catch let error as NSError {
                print("failed \(error)")
            }
        }
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let vc = segue.destination as? TrailerViewController {
            vc.movieId = movie.id
        }
    }
 

}
