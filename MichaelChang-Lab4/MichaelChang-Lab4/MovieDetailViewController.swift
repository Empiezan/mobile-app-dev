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
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if movieId != nil {
            getMovieData()
        }
    }
    
    func getMovieData() {
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)/release_dates?api_key=29689c3db85cc939c7b90bed28d5cb85")
        let data = try! Data(contentsOf: url!)
        let json = try! JSONDecoder().decode(TMDbSearchResult.self, from: data)
        for locale in json.results {
            if let rating = locale.certification {
                ratingLabel.text = "Rating: \(rating)"
            }
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
