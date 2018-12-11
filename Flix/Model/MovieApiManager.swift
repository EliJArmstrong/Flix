//
//  MovieApiManager.swift
//  Flix
//
//  Created by Eli Armstrong on 12/10/18.
//  Copyright © 2018 Eli Armstrong. All rights reserved.
//

import Foundation

class MovieApiManager {
    
    static let baseUrl = "https://api.themoviedb.org/3/movie/"
    static let apiKey = "b98a0ccc0f9f7eb5813cde80b7af85e3"
    var session: URLSession
    
    init() {
        session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
    }
    
    func nowPlayingMovies(completion: @escaping ([Movie]?, Error?) -> ()) {
        let url = URL(string: MovieApiManager.baseUrl + "now_playing?api_key=\(MovieApiManager.apiKey)")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let movieDictionaries = dataDictionary["results"] as! [[String: Any]]
                
                let movies = Movie.dicToMovies(dictionaries: movieDictionaries)
                completion(movies, nil)
            } else {
                completion(nil, error)
            }
        }
        task.resume()
    }
    
    func superHeroMovies(completion: @escaping ([Movie]?, Error?) -> ()){
        let url = URL(string: "\(MovieApiManager.baseUrl)363088/similar?api_key=\(MovieApiManager.apiKey)&language=en-US&page=1")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let movieDictionaries = dataDictionary["results"] as! [[String: Any]]
                
                let movies = Movie.dicToMovies(dictionaries: movieDictionaries)
                completion(movies, nil)
            } else {
                completion(nil, error)
            }
        }
        task.resume()
    }
    
    func youTubeUrl(id: Int, completion: @escaping (URL?, Error?) -> ()){
        let url = URL(string: "\(MovieApiManager.baseUrl)\(id)/videos?api_key=\(MovieApiManager.apiKey)&language=en-US?autoplay=1")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]

                let trailerInfo = dataDictionary["results"] as! [[String : Any]]
                let firstTrailerInfo = trailerInfo[0] as [String:Any]
                let key = firstTrailerInfo["key"] as! String
                let url = URL(string: "https://www.youtube.com/embed/\(key)")!
                completion(url, nil)
            } else {
                completion(nil, error)
            }
        }
        task.resume()
    }
}
