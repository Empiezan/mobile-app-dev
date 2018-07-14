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
    
    
    var totalNumPages = 1
    var currPage = 1
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
            genreButton.setTitle("Genre: \(currGenre.name)", for: .normal)
        }
    }
    
    var lastEdit : NSDate!
    
    var genrePickerView : UIPickerView!
    var genrePickerAlert : UIAlertController!
    var genreVC : GenreViewController!
    
    @IBOutlet weak var movieSearchBar: UISearchBar!
    @IBOutlet weak var movieCollection: UICollectionView!
    @IBOutlet weak var genreButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        movieCollection.alwaysBounceVertical = true
        setSpinner()
        getPopularMovies()
//        setUpGenrePicker()
        getGenres()
//        setUpRefresher()
    }
    
//    func setUpRefresher() {
//        refresher = UIRefreshControl()
//        refresher.addTarget(self, action: #selector(getMoviesByQuery), for: .valueChanged)
//        movieCollection.alwaysBounceVertical = true
//        movieCollection.addSubview(refresher)
//    }

    
    override func viewWillAppear(_ animated: Bool) {
//        print(currGenre.name)
        filteredMovieIndices.removeAll()
        if let vc = genreVC {
            currGenre = vc.currGenre
//            genreButton.setTitle("Genre: \(vc.currGenre.name)", for: .normal)
            for i in 0...movies.count-1 {
//                print(movies[i].genre_ids)
//                print(currGenre.id)
                if movies[i].genre_ids.contains(currGenre.id) {
                    filteredMovieIndices.append(i)
                }
            }
            movieCollection.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    @IBAction func chooseGenre(_ sender: Any) {
//        self.present(genrePickerAlert, animated: true)
//    }
    
    func getGenres() {
        DispatchQueue.global(qos: .background).async {
            do {
                let url = URL(string: "https://api.themoviedb.org/3/genre/movie/list?api_key=29689c3db85cc939c7b90bed28d5cb85&language=en-US")
                let data = try Data(contentsOf: url!)
                let json = try JSONDecoder().decode(GenreResult.self, from: data)
                for genre in json.genres {
//                    let genreVC = self.childViewControllers[1] as! GenreViewController
//                    genreVC.genres.append(genre)
//                    print(self.childViewControllers.count)
                    self.genres.append(genre)
//                    print(genre.id)
//                    print(genre.name)
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
        spinner.startAnimating()
        if searchText == "" {
            getMoviesByQuery()
        }
    }
    
    @IBAction func search(_ sender: Any) {
        spinner.startAnimating()
        getMoviesByQuery()
    }
    
    func getMoreMovies() {
        let searchText = movieSearchBar.text!
        let nextPage = currPage + 1
        if !(nextPage >= totalNumPages) {
            DispatchQueue.global(qos: .background).async {
                do {
                    let query = searchText.replacingOccurrences(of: " ", with: "+")
                    let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=29689c3db85cc939c7b90bed28d5cb85&query=\(query)&page=\(nextPage)")
                    let data = try Data(contentsOf: url!)
                    let json = try JSONDecoder().decode(TMDbSearchResult.self, from: data)
                    self.totalNumPages = json.total_pages
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
//                        self.refresher.endRefreshing()
                        self.currPage += 1
                        self.movieCollection.reloadData()
//                        print("done")
                    }
                } catch {
                    //                Display some message about not having internet access
//                    let noInternet = UIAlertController(title: "Error Loading", message: "Please check your internet connection and refresh the page", preferredStyle: .alert)
//                    noInternet.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
//                    self.present(noInternet, animated: true)
                }
            }
        }
    }
 
    @objc func getMoviesByQuery() {
        movies.removeAll()
        imageCache.removeAll()
        let searchText = movieSearchBar.text!
        if searchText.isEmpty {
            //TODO: implement multiple pages for popular movies
            movies = popularMovies
//            currGenre = Genre(id: 0, name: "All")
//            genreButton.setTitle(currGenre.name, for: .normal)
            imageCache = popularMoviesImages
            spinner.stopAnimating()
//            refresher.endRefreshing()
            movieCollection.reloadData()
            return
        }
        
        DispatchQueue.global(qos: .userInteractive).async {
            do {
                print(searchText)
                let query = searchText.replacingOccurrences(of: " ", with: "+")
                let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=29689c3db85cc939c7b90bed28d5cb85&query=\(query)")
                let data = try Data(contentsOf: url!)
                let json = try JSONDecoder().decode(TMDbSearchResult.self, from: data)
                self.totalNumPages = json.total_pages
                self.currPage = 1
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
//                    self.refresher.endRefreshing()
                    self.movieCollection.reloadData()
                    print(self.movies.count)
                    print(self.imageCache.count)
                }
            } catch {
//                Display some message about not having internet access
//                let noInternet = UIAlertController(title: "Error Loading", message: "Please check your internet connection and refresh the page", preferredStyle: .alert)
//                noInternet.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
//                self.present(noInternet, animated: true)
            }
        }
    
    }
 
    func getPopularMovies() {
        spinner.startAnimating()
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=29689c3db85cc939c7b90bed28d5cb85")
                let data = try Data(contentsOf: url!)
                let json = try JSONDecoder().decode(TMDbSearchResult.self, from: data)
                self.popularMovies.removeAll()
                self.imageCache.removeAll()
                for movie in json.results {
                    if let posterPath = movie.poster_path {
                        self.popularMovies.append(movie)
                        
                        let url = URL(string: "https://image.tmdb.org/t/p/w185\(posterPath)")
                        let data = try Data(contentsOf: url!)
                        self.popularMoviesImages.append(UIImage(data: data)!)
                    }
                }

                DispatchQueue.main.async {
                    self.movies = self.popularMovies
                    self.imageCache = self.popularMoviesImages
                    self.movieCollection.reloadData()
                    self.spinner.stopAnimating()
                }
            } catch {
//                Display some message about not having internet access
//                let noInternet = UIAlertController(title: "Error Loading", message: "Please check your internet connection and refresh the page", preferredStyle: .alert)
//                noInternet.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
//                self.present(noInternet, animated: true)
//                let refreshView = UIView(frame: CGRect(x: <#T##CGFloat#>, y: <#T##CGFloat#>, width: <#T##CGFloat#>, height: <#T##CGFloat#>))
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movie = collectionView.dequeueReusableCell(withReuseIdentifier: "movie", for: indexPath) as! MovieCollectionViewCell
        if currGenre.id == 0 {
            movie.movieImageView.image = imageCache[indexPath.row]
            movie.movieTitleLabel.text = movies[indexPath.row].title
            movie.data = movies[indexPath.row]
        } else {
            movie.movieImageView.image = imageCache[filteredMovieIndices[indexPath.row]]
            movie.movieTitleLabel.text = movies[filteredMovieIndices[indexPath.row]].title
            movie.data = movies[indexPath.row]
        }
        
        return movie
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if currGenre.id == 0 {
            return movies.count
        } else {
            return filteredMovieIndices.count
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let collectionHeight = movieCollection.frame.height
        let contentHeight = movieCollection.contentSize.height
        let offsetPosition = movieCollection.contentOffset.y
        if offsetPosition + collectionHeight >= contentHeight {
            //User has scrolled to the bottom of the collection view
            getMoreMovies()
        }
    }
 
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let movieDetailsVC = segue.destination as? MovieDetailViewController {
            if let movie = sender as? MovieCollectionViewCell  {
                movieDetailsVC.movieId = movie.data.id
                movieDetailsVC.movieTitle = movie.data.title
                movieDetailsVC.posterImage = movie.movieImageView.image
                movieDetailsVC.score = Int(movie.data.vote_average * 10)
                movieDetailsVC.releaseDate = movie.data.release_date
            }
        } else if let movieGenresVC = segue.destination as? GenreViewController {
            genreVC = movieGenresVC
            movieGenresVC.genres = genres
        }
    }
    
}

