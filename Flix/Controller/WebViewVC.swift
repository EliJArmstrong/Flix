//
//  WebViewVC.swift
//  Flix
//
//  Created by Eli Armstrong on 11/10/18.
//  Copyright © 2018 Eli Armstrong. All rights reserved.
//

import UIKit
import WebKit

class WebViewVC: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var backLbl: UILabel!
    @IBOutlet weak var loadingLbl: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var webView: WKWebView!
    var id = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        webView.isOpaque = false
        webView.navigationDelegate = self
        let tapGest = UITapGestureRecognizer(target: self, action: #selector(dismiss(animated:completion:)))
        backLbl.addGestureRecognizer(tapGest)
        fetchData()
    }
    
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.activityIndicator.stopAnimating()
        self.loadingLbl.isHidden = true
    }
    
    func fetchData(){
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US?autoplay=1")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data{
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String : Any]
                
                let trailerInfo = dataDictionary["results"] as! [[String : Any]]
                let firstTrailerInfo = trailerInfo[0] as [String:Any]
                let key = firstTrailerInfo["key"] as! String
                let url = URL(string: "https://www.youtube.com/embed/\(key)")!
                self.webView.load(URLRequest(url: url))
            }
        }
        task.resume()
    }
    
    @IBAction func closeVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
