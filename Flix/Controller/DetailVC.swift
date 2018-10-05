//
//  DetailVC.swift
//  Flix
//
//  Created by Eli Armstrong on 10/1/18.
//  Copyright © 2018 Eli Armstrong. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet weak var backDropImg: UIImageView!
    @IBOutlet weak var posterImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var releaseDateLbl: UILabel!
    @IBOutlet weak var overViewText: UITextView!
    
    var movie: [String: Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let movie = movie {
            print(movie)
            titleLbl.text = movie["title"] as? String
            releaseDateLbl.text = movie["release_date"] as? String
            overViewText.text = movie["overview"] as? String
            let backdropPathString = movie["backdrop_path"] as! String
            let posterPathString = movie["poster_path"] as! String
            let baseURLString = "https://image.tmdb.org/t/p/w500"
            
            let backdropURL = URL(string: "\(baseURLString)\(backdropPathString)")!
            backDropImg.af_setImage(withURL: backdropURL)
            
            let posterPathURL = URL(string: "\(baseURLString)\(posterPathString)")!
            posterImg.af_setImage(withURL: posterPathURL)
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
