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
    
    var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        DispatchQueue.main.async {
            let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
            layout.minimumInteritemSpacing = 5
            layout.minimumLineSpacing = layout.minimumInteritemSpacing
            let cellsPerline: CGFloat = 2
            let interItemSpacingTotal = layout.minimumLineSpacing * (cellsPerline  - 1)
            let width = self.collectionView.frame.size.width / cellsPerline - interItemSpacingTotal / cellsPerline
            
            layout.itemSize = CGSize(width: width, height: width * 3/2)
        }
        fetchMovies()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if self.isViewLoaded {
            DispatchQueue.main.async {
                let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
                layout.minimumInteritemSpacing = 5
                layout.minimumLineSpacing = layout.minimumInteritemSpacing
                let cellsPerline: CGFloat = 2
                let interItemSpacingTotal = layout.minimumLineSpacing * (cellsPerline  - 1)
                let width = self.collectionView.frame.size.width / cellsPerline - interItemSpacingTotal / cellsPerline
                
                layout.itemSize = CGSize(width: width, height: width * 3/2)
            }
        }
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if self.isViewLoaded {
            let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
            layout.minimumInteritemSpacing = 5
            layout.minimumLineSpacing = layout.minimumInteritemSpacing
            let cellsPerline: CGFloat = 2
            let interItemSpacingTotal = layout.minimumLineSpacing * (cellsPerline  - 1)
            let width = self.collectionView.frame.size.width / cellsPerline - interItemSpacingTotal / cellsPerline
    
            layout.itemSize = CGSize(width: width, height: width * 3/2)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "posterCell", for: indexPath) as! PosterCell
        let movie = movies[indexPath.item]
        cell.posterImg.af_setImage(withURL: movie.posterUrl!)
        
        return cell
    }
    
    func fetchMovies(){
        MovieApiManager().superHeroMovies { (movies, error) in
            if let error = error{
                print(error.localizedDescription)
            } else if let movies = movies{
                self.movies = movies
                self.collectionView.reloadData()
            }
        }
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
