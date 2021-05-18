//
//  DetailMovieTableViewController.swift
//  JoseFinalProjectIOS2
//
//  Created by Jose M Arguinzzones on 2021-04-12.
//

import UIKit
import WebKit

class DetailMovieTableViewController: UITableViewController {

    let movieInfoController = MovieInfoController()
    var result: ResultMovie?
    var movieImage: UIImage?
    
    init?(coder: NSCoder, result: ResultMovie?, movieImage: UIImage?) {
        self.result = result
        self.movieImage = movieImage
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var favoriteBarButton: UIBarButtonItem!
    @IBOutlet weak var imageViewDetail: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var overviewTextView: UITextView!
    @IBOutlet weak var releaseDateTextField: UITextField!
    @IBOutlet weak var myWKWebView: WKWebView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
       
        if let result = result {
            imageViewDetail.image = movieImage
            nameTextField.text = result.title
            overviewTextView.text = result.overview
            releaseDateTextField.text = result.release_date
            title = "Detail Movie"
            
            movieInfoController.fetchVideo(video: result.id!) { (items) in
                DispatchQueue.main.sync {
                    let myURL = URL(string: (videos[0].results[0].video_url!))
                    let youtubeRequest = URLRequest(url: myURL!)
                    self.myWKWebView.load(youtubeRequest)
                    self.checkIsFavorite()
                }
            }
        } else {
            title = "Detail Movie"
        }
    }
    @IBAction func favoritesPressed(_ sender: UIBarButtonItem) {

        if favoriteBarButton.image == UIImage(systemName: "star"){
            var favorite = Favorite()
            favorite.image = imageViewDetail.image?.data!
            favorite.title = nameTextField.text
            favorite.overview = overviewTextView.text
            favorite.releaseDate = releaseDateTextField.text
            favorite.trailer = videos[0].results[0].video_url!
            favorite.voteAverage = result?.vote_average?.description
            favorite.popularity = result?.popularity?.description
            favorites.append(favorite)
            Favorite.saveFavorites(favorites)
            favoriteBarButton.image = UIImage(systemName: "star.fill")
            
        }else if favoriteBarButton.image == UIImage(systemName: "star.fill") {
            for element in favorites {
                if element.title == nameTextField.text{
                    if let index = favorites.firstIndex(of: element) {
                        favorites.remove(at: index)
                        Favorite.saveFavorites(favorites)
                        favoriteBarButton.image = UIImage(systemName: "star")
                    }
                }
            }
        }
    }
    
    func checkIsFavorite() {
        for element in favorites {
            if element.title == nameTextField.text{
                favoriteBarButton.image = UIImage(systemName: "star.fill")
            }

        }
    }
    
}
