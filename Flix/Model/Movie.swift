//
//  Movie.swift
//  Flix
//
//  Created by Eli Armstrong on 12/10/18.
//  Copyright © 2018 Eli Armstrong. All rights reserved.
//

import Foundation


class Movie{
    var title: String
    var overview: String
    var posterUrl: URL?
    var releaseDate: String
    var backDropURl: URL?
    var id: Int
    
    
    let baseURLString = "https://image.tmdb.org/t/p/w500"
    
    
    init(dictionary: [String: Any]) {
        title = dictionary["title"] as? String ?? "No title"
        overview = dictionary["overview"] as? String ?? ""
        releaseDate = dictionary["release_date"] as? String ?? ""
        id = dictionary["id"] as? Int ?? 42
        
        
        let posterPathString = dictionary["poster_path"] as? String ?? ""
        let backdropPathString = dictionary["backdrop_path"] as? String ?? ""
        
        
        posterUrl = URL(string: "\(baseURLString)\(posterPathString)")!    // Set the rest of the properties
        backDropURl = URL(string: "\(baseURLString)\(backdropPathString)")
    }
    
    class func dicToMovies(dictionaries: [[String: Any]]) -> [Movie] {
        var movies: [Movie] = []
        for dictionary in dictionaries {
            let movie = Movie(dictionary: dictionary)
            movies.append(movie)
        }
        
        return movies
    }

}
