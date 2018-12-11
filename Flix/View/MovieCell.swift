//
//  MovieCell.swift
//  Flix
//
//  Created by Eli Armstrong on 8/31/18.
//  Copyright © 2018 Eli Armstrong. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieCell: UITableViewCell {
    
    var movie: Movie!{
        didSet{
            titleLbl.text = movie.title
            overviewLbl.text = movie.overview
            let filter = AspectScaledToFillSizeWithRoundedCornersFilter(
                size: self.posterImg.frame.size,
                radius: 20.0
            )
            posterImg.af_setImage(withURL: movie.posterUrl!, placeholderImage: placeholderImage, filter: filter, imageTransition: .crossDissolve(0.2))
        }
    }
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var overviewLbl: UILabel!
    @IBOutlet weak var posterImg: UIImageView!
    
    let placeholderImage = UIImage(named: "launch_image")!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        self.selectionStyle = .none
        
        if self.isSelected{
            let backgroundView = UIView()
            backgroundView.backgroundColor = UIColor.white
            self.selectedBackgroundView = backgroundView
            self.titleLbl.textColor = UIColor.black
            self.overviewLbl.textColor = UIColor.black
        } else{
            let backgroundView = UIView()
            backgroundView.backgroundColor = UIColor.black
            self.selectedBackgroundView = backgroundView
            self.titleLbl.textColor = UIColor.white
            self.overviewLbl.textColor = UIColor.white
        }
        
    }

}
