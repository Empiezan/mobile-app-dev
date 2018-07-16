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
// 4. How to show alerts (https://learnappmaking.com/uialertcontroller-alerts-swift-how-to/)
// 5. How to refresh collection view with pull down gesture (https://stackoverflow.com/questions/35362440/pull-to-refresh-in-uicollectionview-in-viewcontroller)

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate {

    
    
    
    var totalNumPages = Int.max
    var currPage = 0
    var searchText = String()
    var movies : [MovieData] = []
    var filteredMovieIndices = [Int]()
    var popularMovies : [MovieData] = []
    var spinner : UIActivityIndicatorView!
    var refresher:UIRefreshControl!
    var imageCache = [UIImage]()
    var popularMoviesImages = [UIImage]()
    var genres = [Genre(id: 0, name: "All")]
    var currGenre : Genre = Genre(id: 0, name: "All") {
        didSet {
            genreButton.setTitle("Filter: \(currGenre.name)", for: .normal)
        }
    }
    
    var genreVC : GenreViewController!
    
    @IBOutlet weak var movieSearchBar: UISearchBar!
    @IBOutlet weak var movieCollection: UICollectionView!
    @IBOutlet weak var genreButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        movieCollection.alwaysBounceVertical = true
        setSpinner()
        getGenres()
        getMovies()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        filterMovies()
        movieCollection.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getGenres() {
        DispatchQueue.global().async {
            do {
                let url = URL(string: "https://api.themoviedb.org/3/genre/movie/list?api_key=29689c3db85cc939c7b90bed28d5cb85&language=en-US")
                let data = try Data(contentsOf: url!)
                let json = try JSONDecoder().decode(GenreResult.self, from: data)
                for genre in json.genres {
                    self.genres.append(genre)
                }
            } catch {
                
            }
        }
    }
    
    @IBAction func showAttribution(_ sender: Any) {
        let att = UIAlertController(title: "Credits", message: "This product uses the TMDb API but is not endorsed or certified by TMDb.", preferredStyle: .alert)
        att.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(att, animated: true)
    }
    
    func setSpinner() {
        spinner = UIActivityIndicatorView(frame: CGRect(x: view.center.x, y: view.center.y, width: 50, height: 50))
        spinner.hidesWhenStopped = true
        view.addSubview(spinner)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
        currPage = 0
        totalNumPages = Int.max
        if searchText.isEmpty {
            movies.removeAll()
            filteredMovieIndices.removeAll()
            imageCache.removeAll()
            getMovies()
        }
    }
    
    @IBAction func search(_ sender: Any) {
        spinner.startAnimating()
        
        movies.removeAll()
        filteredMovieIndices.removeAll()
        imageCache.removeAll()
        
        getMovies()
    }
 
    func getMovies() {
        let nextPage = currPage + 1
        
        if nextPage <= totalNumPages {
            spinner.startAnimating()
            DispatchQueue.global().async {
                do {
                    var url : URL!
                    let query = self.searchText.replacingOccurrences(of: " ", with: "+")
                    if self.searchText.isEmpty {
                        url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=29689c3db85cc939c7b90bed28d5cb85&page=\(nextPage)")
                    } else {
                        url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=29689c3db85cc939c7b90bed28d5cb85&query=\(query)&page=\(nextPage)")
                    }
                    
                    let data = try Data(contentsOf: url!)
                    let json = try JSONDecoder().decode(TMDbSearchResult.self, from: data)
                    self.totalNumPages = json.total_pages
                    self.currPage += 1
                    for movie in json.results {
                        if let posterPath = movie.poster_path {
                            self.movies.append(movie)
                            
                            let url = URL(string: "https://image.tmdb.org/t/p/w185\(posterPath)")
                            let data = try Data(contentsOf: url!)
                            self.imageCache.append(UIImage(data: data)!)
                        }
                    }
                    DispatchQueue.main.async {
                        self.spinner.stopAnimating()
                        self.filterMovies()
                        self.movieCollection.reloadData()
                    }
                } catch {
                    print("Error in fetching movies")
                }
            }
        }
    }
    
    func filterMovies() {
        filteredMovieIndices.removeAll()
        if let vc = genreVC {
            currGenre = vc.currGenre
            for i in 0...movies.count-1 {
                if currGenre.id == 0 || movies[i].genre_ids.contains(currGenre.id) {
                    filteredMovieIndices.append(i)
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if currGenre.id == 0 {
            return movies.count
        } else {
            return filteredMovieIndices.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = movieCollection.dequeueReusableCell(withReuseIdentifier: "movie", for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        if currGenre.id == 0 {
            cell.movieImageView.image = imageCache[indexPath.row]
            cell.movieTitleLabel.text = movies[indexPath.row].title
            cell.data = movies[indexPath.row]
        } else {
            cell.movieImageView.image = imageCache[filteredMovieIndices[indexPath.row]]
            cell.movieTitleLabel.text = movies[filteredMovieIndices[indexPath.row]].title
            cell.data = movies[indexPath.row]
        }
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let collectionHeight = movieCollection.frame.height
        let contentHeight = movieCollection.contentSize.height
        let offsetPosition = movieCollection.contentOffset.y
        if offsetPosition + collectionHeight >= contentHeight {
            //User has scrolled to the bottom of the collection view
            getMovies()
        }
    }
 
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let movieDetailsVC = segue.destination as? MovieDetailViewController {
            if let movie = sender as? MovieCollectionViewCell  {
                movieDetailsVC.movie = movie.data
            }
        } else if let movieGenresVC = segue.destination as? GenreViewController {
            genreVC = movieGenresVC
            movieGenresVC.genres = genres
        }
    }
    
}

