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
    
    var movie: Movie?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        
        backDropImg.isUserInteractionEnabled = true
        backDropImg.addGestureRecognizer(tapGestureRecognizer)
        
        if let movie = movie {
            titleLbl.text = movie.title
            releaseDateLbl.text = movie.releaseDate
            overViewText.text = movie.overview
            backDropImg.af_setImage(withURL: movie.backDropURl!)
            posterImg.af_setImage(withURL: movie.posterUrl!)
        }
        
        DispatchQueue.main.async {
            self.overViewText.setContentOffset(.zero, animated: false)
        }
    }
    
    
    // This is so when the phone rotated this will cause the UITextView to go to the top
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        DispatchQueue.main.async {
            self.overViewText.setContentOffset(.zero, animated: false)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let webViewVC = segue.destination as! WebViewVC
        webViewVC.id = movie?.id ?? 42
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        performSegue(withIdentifier: "ShowWebViewVC", sender: nil)
    }
    
}
