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
    
    @IBOutlet weak var backImg: UIImageView!
    @IBOutlet weak var backLbl: UILabel!
    @IBOutlet weak var loadingLbl: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var webView: WKWebView!
    var id: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        webView.isOpaque = false
        webView.navigationDelegate = self
        fetchData()
    }
    
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.activityIndicator.stopAnimating()
        self.loadingLbl.isHidden = true
    }
    
    func fetchData(){
        MovieApiManager().youTubeUrl(id: id!) { (url, error) in
            self.webView.load(URLRequest(url: url!))
        }
    }
    
    @IBAction func closeVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
