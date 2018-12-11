//
//  ViewController.swift
//  Flix
//
//  Created by Eli Armstrong on 8/31/18.
//  Copyright © 2018 Eli Armstrong. All rights reserved.
//

import UIKit
import AlamofireImage

class NowPlayingVC: UIViewController, UITableViewDataSource, UISearchBarDelegate {
    
    // Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var movies = [Movie]()
    var filterMovies = [Movie]()
    var refreshControl: UIRefreshControl!
    let alertController = UIAlertController(title: "Title", message: "Message", preferredStyle: .alert)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tryAgain = UIAlertAction(title: "Try Again", style: .default) { (action) in
            self.fetchMovies()
        }
        self.alertController.addAction(tryAgain)
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(NowPlayingVC.didPullToRefresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        tableView.dataSource = self
        searchBar.delegate = self
        fetchMovies()
        
        tableView.estimatedRowHeight = 190
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if let index = self.tableView.indexPathForSelectedRow{
            self.tableView.deselectRow(at: index, animated: true)
        }
    }
    
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl){
        fetchMovies()
    }
    
    func fetchMovies(){
        MovieApiManager().nowPlayingMovies { (movies, error) in
            if let error = error{
                self.alertController.title = "Cannot Get Movies"
                self.alertController.message = error.localizedDescription
                self.present(self.alertController, animated: true){}
                print(error.localizedDescription)
            } else if let movies = movies{
                self.movies = movies
                self.filterMovies = movies
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.movie = filterMovies[indexPath.row]
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell){
            let moive = filterMovies[indexPath.row]
            let detailVC = segue.destination as! DetailVC
            detailVC.movie = moive
        }
        searchBar.resignFirstResponder()
    }
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        
        self.filterMovies = searchText.isEmpty ? self.movies : movies.filter({ (filteredMovies: Movie) -> Bool in
            let title = filteredMovies.title
            return title.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        self.filterMovies = self.movies
        tableView.reloadData()
    }
}

