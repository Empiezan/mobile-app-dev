//
//  TrailerViewController.swift
//  MichaelChang-Lab4
//
//  Created by labuser on 7/14/18.
//  Copyright © 2018 mc. All rights reserved.
//

import UIKit
import WebKit

class TrailerViewController: UIViewController {

    var movieId : Int!
    
    @IBOutlet weak var trailerView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getTrailer()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getTrailer() {
        DispatchQueue.global().async {
            do {
                let url = URL(string: "https://api.themoviedb.org/3/movie/\(self.movieId!)/videos?api_key=29689c3db85cc939c7b90bed28d5cb85&language=en-US")
                let data = try Data(contentsOf: url!)
                let json = try JSONDecoder().decode(VideoResult.self, from: data)
                
                DispatchQueue.main.async {
                    for video in json.results {
                        if video.site == "YouTube" && video.type == "Trailer" {
                            let url = URL(string: "https://www.youtube.com/watch?v=\(video.key)")
                            self.trailerView.load(URLRequest(url: url!))
                            return
                        }
                    }
//                    self.trailerView.isHidden = true
//                    self.showMessage()
                }
            } catch {
                print("Error in fetching trailer video")
//                self.trailerView.isHidden = true
//                self.showMessage()
            }
        }

    }
    
    func showMessage() {
        let noTrailers = UILabel(frame: CGRect(x: trailerView.center.x - 75, y: trailerView.center.y - 100, width: 250, height: 100))
        noTrailers.text = "No Trailer Available"
        view.addSubview(noTrailers)
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
