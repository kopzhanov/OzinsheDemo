//
//  HistoryTableViewCell.swift
//  OzinsheDemo
//
//  Created by Alikhan Kopzhanov on 15.11.2023.
//

import UIKit
import SDWebImage

class HistoryTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var delegate : MovieProtocol?
    
    var mainMovie = MainMovies()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(mainMovie : MainMovies) {
        self.mainMovie = mainMovie
        collectionView.reloadData()
    }

    //MARK: - Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainMovie.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        let transformer = SDImageResizingTransformer(size: CGSize(width: 184, height: 112), scaleMode: .aspectFill)
        
        //Image View
        let imageView = cell.viewWithTag(1000) as! UIImageView
        imageView.sd_setImage(with: URL(string: mainMovie.movies[indexPath.row].poster_link),placeholderImage: nil, context: [.imageTransformer:transformer])
        imageView.layer.cornerRadius = 8
        
        let movieNameLabel = cell.viewWithTag(1001) as! UILabel
        movieNameLabel.text = mainMovie.movies[indexPath.row].name
        
        let movieGenreNameLabel = cell.viewWithTag(1002) as! UILabel
        if let genreName = mainMovie.movies[indexPath.row].genres.first {
            movieGenreNameLabel.text = genreName.name
        } else {
            movieGenreNameLabel.text = ""
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        delegate?.movieDidSelect(movie: mainMovie.movies[indexPath.row])
    }
}
