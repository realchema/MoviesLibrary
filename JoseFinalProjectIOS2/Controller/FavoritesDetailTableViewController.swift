//
//  FavoritesDetailTableViewController.swift
//  JoseFinalProjectIOS2
//
//  Created by Jose M Arguinzzones on 2021-04-13.
//

import UIKit
import WebKit
import SafariServices
import MessageUI

class FavoritesDetailTableViewController: UITableViewController {
    
    var isfavoriteDetailTextView = false
    let showLabelIndexPath = IndexPath(row: 0, section: 2)
    let favoriteDetailTextVieIndexPath = IndexPath(row: 1, section: 2)
    
    var favorite: Favorite?
    var index: Int?
    
    init?(coder: NSCoder, favorite: Favorite?, index: Int?) {
        self.favorite = favorite
        self.index = index
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var siteButton: UIButton!
    
    @IBOutlet weak var favoriteDetailImageView: UIImageView!
    @IBOutlet weak var favoriteDetailNameLabel: UITextField!
    @IBOutlet weak var favoriteDetailTextView: UITextView!
    @IBOutlet weak var favoriteDetailReleaseDate: UITextField!
    @IBOutlet weak var favoriteDetailWebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let favorite = favorite {
            favoriteDetailImageView.image = favorite.image?.image!
            favoriteDetailNameLabel.text = favorite.title
            favoriteDetailTextView.text = favorite.overview
            favoriteDetailReleaseDate.text = favorite.releaseDate
            let myURL = URL(string: (favorite.trailer!))
            let youtubeRequest = URLRequest(url: myURL!)
            self.favoriteDetailWebView.load(youtubeRequest)
            title = "Detail Favorite Movie"
        } else {
            title = "Detail Favorite Movie"
        }
        
    }
    
    
    @IBAction func shareButtonPressed(_ sender: UIButton) {
        guard let image = favoriteDetailImageView.image else { return }
    
        let activityController = UIActivityViewController(activityItems: [image],
                                                          applicationActivities: nil)
       
        activityController.popoverPresentationController?.sourceView = sender
        present(activityController, animated: true, completion: nil)
    }
    
    
    @IBAction func siteButtonPressed(_ sender: UIButton) {
        if let url = URL(string: (favorite?.trailer)!) {
            let safariViewController = SFSafariViewController(url:url)
            present(safariViewController, animated: true, completion: nil)
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch (indexPath.section, indexPath.row) {
               case (favoriteDetailTextVieIndexPath.section,
                     favoriteDetailTextVieIndexPath.row):
                if isfavoriteDetailTextView {
                    return 216.0
                } else {
                    return 0.0
                }
        default:
           
            return UITableView.automaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath == showLabelIndexPath {
            isfavoriteDetailTextView.toggle()
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "saveFavoriteUnwind" else { return }
        favorite?.title = favoriteDetailNameLabel.text ?? ""
        favorite?.overview = favoriteDetailTextView.text ?? ""
        favorite?.releaseDate = favoriteDetailReleaseDate.text ?? ""
    }


}
