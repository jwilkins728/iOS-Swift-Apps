//
//  MovieCell.swift
//  MyFavoriteMovies
//
//  Created by Ralph Cachero on 1/21/16.
//  Copyright © 2016 Teradek. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var movieReason: UILabel!
    @IBOutlet weak var movieLink: UILabel!
    @IBOutlet weak var movieImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(movie: Movie) {
        movieTitle.text = movie.title
        movieYear.text = movie.year
        movieReason.text = movie.reason
        movieLink.text = movie.link
        movieImg.image = movie.getMovieImg()
    }
    
}
