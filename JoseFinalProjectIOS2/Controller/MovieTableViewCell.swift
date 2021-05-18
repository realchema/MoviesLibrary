//
//  MovieTableViewCell.swift
//  JoseFinalProjectIOS2
//
//  Created by Jose M Arguinzzones on 2021-04-12.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    let movieInfoController = MovieInfoController()
    
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func updateUI(with movieInfo: ResultMovie, index: Int) {
        movieInfoController.fetchImage(from: movieInfo.poster_url!) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self.imageView2.image = image
                    imageData.append(image)
                    self.descriptionLabel.text = "Rating: \(movieInfo.vote_average?.description ?? "")"
                    self.nameLabel.text = movieInfo.title
                    self.popularityLabel.text = "Popularity \(movieInfo.popularity?.description ?? "")"
                case .failure(let error):
                    self.updateUI(with: error)
                }
            }
        }
    }
    
    func updateUI(with error: Error) {
        imageView2.image = UIImage(systemName: "exclamationmark.octagon")
        descriptionLabel.text = error.localizedDescription
        nameLabel.text = ""
    }
}

