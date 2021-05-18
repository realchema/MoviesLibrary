//
//  Movie.swift
//  JoseFinalProjectIOS2
//
//  Created by Jose M Arguinzzones on 2021-04-11.
//
import Foundation
import UIKit

struct Movie: Codable {
    let page: Int
    let totalResults: Int?
    let totalPages: Int?
    var results: [ResultMovie]
    var image: [UIImage]?
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results = "results"
    }
    
}

struct ResultMovie: Codable {
    let popularity: Double?
    let vote_count: Int?
    let video: Bool?
    var poster_path: String?
    let id: Int?
    let adult: Bool?
    let backdrop_path: String?
    let originalLanguage: OriginalLanguage?
    let originalTitle: String?
    let genreIDS: [Int]?
    let title: String?
    let vote_average: Double?
    let overview, release_date: String?
    var poster_url: String?{
      return "https://image.tmdb.org/t/p/w500" + poster_path!
   
    }

}

enum OriginalLanguage: String, Codable {
    case en = "en"
    case es = "es"
}

var movies = [Movie]()
var imageData = [UIImage]()

extension UIImage {
    var data: Data? {
        if let data = self.jpegData(compressionQuality: 1.0) {
            return data
        } else {
            return nil
        }
    }
}

extension Data {
    var image: UIImage? {
        if let image = UIImage(data: self) {
            return image
        } else {
            return nil
        }
    }
}
