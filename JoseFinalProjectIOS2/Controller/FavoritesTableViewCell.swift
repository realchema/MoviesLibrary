//
//  FavoritesTableViewCell.swift
//  JoseFinalProjectIOS2
//
//  Created by Jose M Arguinzzones on 2021-04-13.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet weak var favoriteNameLabel: UILabel!
    @IBOutlet weak var favoriteDescriptionLabel: UILabel!
    @IBOutlet weak var favoritePopularityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func updateUI(with favoriteInfo: Favorite, index: Int){
        if favorites.isEmpty {
            favoriteImageView.image = UIImage(systemName: "exclamationmark.octagon")
            favoriteNameLabel.text = "No Favorites"
            favoriteDescriptionLabel.text = "No Favorites"
            favoritePopularityLabel.text = "No Info"
        } else {
            favoriteImageView.image = favoriteInfo.image?.image!
            favoriteNameLabel.text = favoriteInfo.title
            favoriteDescriptionLabel.text = "Rating: \(favoriteInfo.voteAverage ?? "")"
            favoritePopularityLabel.text = "Popularity: \(favoriteInfo.popularity ?? "")"
        }
    }

}
