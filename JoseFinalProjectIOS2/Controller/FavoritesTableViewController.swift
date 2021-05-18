//
//  FavoritesTableViewController.swift
//  JoseFinalProjectIOS2
//
//  Created by Jose M Arguinzzones on 2021-04-13.
//

import UIKit

class FavoritesTableViewController: UITableViewController {

    weak var delegate: FavoritesTableViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
        title = "Favorites"
        tableView.reloadData()
        
        if let savedFavorites = Favorite.loadFavorites() {
                favorites = savedFavorites
            }
    }
    
    @IBAction func unwindToFavoriteTableView(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveFavoriteUnwind",
            let sourceViewController = segue.source as? FavoritesDetailTableViewController,
            let favorite = sourceViewController.favorite else { return }
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            
            favorites[selectedIndexPath.row] = favorite
            tableView.reloadRows(at: [selectedIndexPath], with: .none)
            Favorite.saveFavorites(favorites)
        }
    }
    
    @IBSegueAction func showFavoritesDetail(_ coder: NSCoder, sender: Any?) -> FavoritesDetailTableViewController? {
        if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
            let favoriteToDisplay = favorites[indexPath.row]
            return FavoritesDetailTableViewController(coder: coder, favorite: favoriteToDisplay, index: indexPath.row)
        }else{
            return FavoritesDetailTableViewController(coder: coder, favorite: nil, index: nil)
        }
    }
    
    @IBAction func sortByNameBarButton(_ sender: UIBarButtonItem) {
       let sorted = favorites.sorted(by: { ($0.title)! < ($1.title)! })
        favorites = sorted
        Favorite.saveFavorites(favorites)
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return favorites.count
        } else {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as! FavoritesTableViewCell

        let favorite = favorites[indexPath.row]
        cell.updateUI(with: favorite, index: indexPath.row)
        cell.showsReorderControl = true
        
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            favorites.remove(at: indexPath.row)
            Favorite.saveFavorites(favorites)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        } else if editingStyle == .insert {
        
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let movedFavorite = favorites.remove(at: fromIndexPath.row)
            favorites.insert(movedFavorite, at: to.row)
            Favorite.saveFavorites(favorites)
            tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

}

protocol FavoritesTableViewControllerDelegate: AnyObject {
    func favoritesTapped(sender: FavoritesTableViewController)
    
}
