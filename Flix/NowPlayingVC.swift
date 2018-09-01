//
//  ViewController.swift
//  Flix
//
//  Created by Eli Armstrong on 8/31/18.
//  Copyright © 2018 Eli Armstrong. All rights reserved.
//

import UIKit

class NowPlayingVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=b98a0ccc0f9f7eb5813cde80b7af85e3&language=en-US&page=1")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data{
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String : Any]
                
                let movies = dataDictionary["results"] as! [[String : Any]]
                for movie in movies{
                    let title = movie["title"] as! String
                    print(title)
                }
            }
        }
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

