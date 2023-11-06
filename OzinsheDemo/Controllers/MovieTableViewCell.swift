//
//  MovieTableViewCell.swift
//  OzinsheDemo
//
//  Created by Alikhan Kopzhanov on 21.07.2023.
//

import UIKit
import SDWebImage

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var playView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        posterImageView.layer.cornerRadius = 8
        playView.layer.cornerRadius = 8
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setData(movie: Movie){
        posterImageView.sd_setImage(with: URL(string: movie.poster_link),completed: nil)
        
        nameLabel.text = movie.name
        yearLabel.text = "\(movie.year)"
    }
}
