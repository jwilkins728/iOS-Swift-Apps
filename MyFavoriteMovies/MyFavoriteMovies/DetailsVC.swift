//
//  DetailsVC.swift
//  MyFavoriteMovies
//
//  Created by Ralph Cachero on 1/22/16.
//  Copyright © 2016 Teradek. All rights reserved.
//

import UIKit

class DetailsVC: UIViewController {
    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieReason: UILabel!
    @IBOutlet weak var moviePlot: UILabel!
    @IBOutlet weak var movieLink: UILabel!
    @IBOutlet weak var movieImg: UIImageView!
    
    var movie: Movie!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieTitle.text = movie.title
        movieReason.text = movie.reason
        moviePlot.text = movie.plot
        movieLink.text = movie.link
        movieImg.image = movie.getMovieImg()
        
        movieImg.clipsToBounds = true

    }

}
