//
//  SuperheroVC.swift
//  Flix
//
//  Created by Eli Armstrong on 10/1/18.
//  Copyright © 2018 Eli Armstrong. All rights reserved.
//

import UIKit

class SuperheroVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var movies: [[String: Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = layout.minimumInteritemSpacing
        let cellsPerline: CGFloat = 1
        let interItemSpacingTotal = layout.minimumLineSpacing * (cellsPerline  - 1)
        let width = collectionView.frame.size.width / cellsPerline - interItemSpacingTotal / cellsPerline
        
        layout.itemSize = CGSize(width: width, height: width * 3/2)
        
        fetchMovies()
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "posterCell", for: indexPath) as! PosterCell
        let movie = movies[indexPath.item]
        if let posterPathString = movie["poster_path"] as? String {
            let baseURLString = "https://image.tmdb.org/t/p/w500"
            let posterURL = URL(string: "\(baseURLString)\(posterPathString)")!
            cell.posterImg.af_setImage(withURL: posterURL)
        }
        
        return cell
    }
    
    func fetchMovies(){
        let url = URL(string: "https://api.themoviedb.org/3/movie/363088/similar?api_key=b98a0ccc0f9f7eb5813cde80b7af85e3&language=en-US&page=1")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                //                self.alertController.title = "Cannot Get Movies"
                //                self.alertController.message = error.localizedDescription
                //                self.present(self.alertController, animated: true){}
                print(error.localizedDescription)
            } else if let data = data{
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String : Any]
                
                let movies = dataDictionary["results"] as! [[String : Any]]
                self.movies = movies
                //                self.filterMovies = movies
                self.collectionView.reloadData()
                
            }
        }
        task.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UICollectionViewCell
        if let indexPath = collectionView.indexPath(for: cell){
            let moive = movies[indexPath.item]
            let detailVC = segue.destination as! DetailVC
            detailVC.movie = moive
        }
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
