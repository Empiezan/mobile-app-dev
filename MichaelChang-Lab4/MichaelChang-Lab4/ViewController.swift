//
//  ViewController.swift
//  MichaelChang-Lab4
//
//  Created by macos on 7/5/18.
//  Copyright © 2018 mc. All rights reserved.
//
// Credits
// 1. https://openclipart.org/detail/144715/movie-clapper-board
// 2. https://openclipart.org/detail/93367/favorite-icon
// 3. https://www.youtube.com/watch?v=Ys8cDERQPuU

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate {
    
    var movies : [MovieData] = []
    var spinner : UIActivityIndicatorView!
    @IBOutlet weak var movieSearchBar: UISearchBar!
    @IBOutlet weak var movieCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        spinner = UIActivityIndicatorView(frame: CGRect(origin: view.center, size: CGSize(width: 50, height: 50)))
        spinner.hidesWhenStopped = true
        view.addSubview(spinner)
        getMovies()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            getMovies()
            return
        }
        spinner.startAnimating()
        print(searchText)
        let query = searchText.replacingOccurrences(of: " ", with: "+")
        let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=29689c3db85cc939c7b90bed28d5cb85&query=\(query)")
        let data = try! Data(contentsOf: url!)
        let json = try! JSONDecoder().decode(TMDbSearchResult.self, from: data)
        movies.removeAll()
        for movie in json.results {
            if let posterPath = movie.poster_path {
                movies.append(MovieData(id: movie.id, poster_path: posterPath, title: movie.title, release_date: movie.release_date, vote_average: movie.vote_average, overview: movie.overview, vote_count: movie.vote_count, certification: "") )
            }
        }
        movieCollection.reloadData()
        spinner.stopAnimating()
    }

    func getMovies() {
        spinner.startAnimating()
        let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=29689c3db85cc939c7b90bed28d5cb85")
        let data = try! Data(contentsOf: url!)
        let json = try! JSONDecoder().decode(TMDbSearchResult.self, from: data)
        movies.removeAll()
        for movie in json.results {
            if let posterPath = movie.poster_path {
                movies.append(MovieData(id: movie.id, poster_path: posterPath, title: movie.title, release_date: movie.release_date, vote_average: movie.vote_average, overview: movie.overview, vote_count: movie.vote_count, certification: "") )
            }
        }
        movieCollection.reloadData()
        spinner.stopAnimating()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movie = collectionView.dequeueReusableCell(withReuseIdentifier: "movie", for: indexPath) as! Movie
        let url = URL(string: "https://image.tmdb.org/t/p/w185\(movies[indexPath.row].poster_path!)")
        //TODO: try and catch safely
        let data = try! Data(contentsOf: url!)
        movie.movieImageView.image = UIImage(data: data)
        movie.movieTitleLabel.text = movies[indexPath.row].title
        return movie
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let movieDetailsVC = segue.destination as? MovieDetailViewController
        guard let movie = sender as? Movie else {
            print("error")
            return
        }
        movieDetailsVC?.movieId = movie.data.id
    }
    
}

