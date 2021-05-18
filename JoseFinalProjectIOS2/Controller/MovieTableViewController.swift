//
//  MovieTableViewController.swift
//  JoseFinalProjectIOS2
//
//  Created by Jose M Arguinzzones on 2021-04-12.
//

import UIKit

class MovieTableViewController: UITableViewController {
    
    let movieInfoController = MovieInfoController()
    var callStatus: Bool = false
    var arrayOfMovies = [Movie]()
    var errorStatus: Error? = nil
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
        title = "Movies"
        
        let query: [String: String] = [
            "api_key": "8f8358ee1f03c592045af0af375edc2d",
            "language": "en-US"
        ]
        movieInfoController.fetchMovieInfo(matching: query) { (result) in
            DispatchQueue.main.sync {
                switch result {
                case .success(let movieInfo):
                    self.callStatus = true
                    self.arrayOfMovies = movieInfo
                    self.count = movies[0].results.count
                    self.tableView.reloadData()
                case .failure(let error):
                    self.errorStatus = error
                    self.callStatus = false
                }
            }
        }
        
    }
    
    @IBAction func unwindToMovieTableView(segue: UIStoryboardSegue) {
       
    }
    
    @IBSegueAction func showDetailMovie(_ coder: NSCoder, sender: Any?) -> DetailMovieTableViewController? {
        if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
            let movieToDisplay = movies[0].results[indexPath.row]
            let movieImage = imageData[indexPath.row]
            return DetailMovieTableViewController(coder: coder, result: movieToDisplay, movieImage: movieImage)
        }else{
            return DetailMovieTableViewController(coder: coder, result: nil, movieImage: nil)
        }
       
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return count
        } else {
            return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieTableViewCell
        
        let movie = movies[0].results[indexPath.row]

        if callStatus{
            cell.updateUI(with: movie, index: indexPath.row)
        }
        else {
            cell.updateUI(with: errorStatus!)
        }
                    
        cell.showsReorderControl = true
        
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
}
