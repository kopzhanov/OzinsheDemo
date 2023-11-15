//
//  GenreAgeTableViewCell.swift
//  OzinsheDemo
//
//  Created by Alikhan Kopzhanov on 15.11.2023.
//

import UIKit
import SDWebImage

class GenreAgeTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
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
        if mainMovie.cellType == .ageCategory{
            return mainMovie.categoryAges.count
        }
        return mainMovie.genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        let transformer = SDImageResizingTransformer(size: CGSize(width: 184, height: 112), scaleMode: .aspectFill)
        
        //Image View
        let imageView = cell.viewWithTag(1000) as! UIImageView
        imageView.layer.cornerRadius = 8
        
        let nameLabel = cell.viewWithTag(1001) as! UILabel
        
        if mainMovie.cellType == .ageCategory {
            imageView.sd_setImage(with: URL(string: mainMovie.categoryAges[indexPath.row].link), placeholderImage:nil, context:[.imageTransformer:transformer])
            nameLabel.text = mainMovie.categoryAges[indexPath.row].name
        } else {
            imageView.sd_setImage(with: URL(string: mainMovie.genres[indexPath.row].link), placeholderImage:nil, context:[.imageTransformer:transformer])
            nameLabel.text = mainMovie.genres[indexPath.row].name
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
