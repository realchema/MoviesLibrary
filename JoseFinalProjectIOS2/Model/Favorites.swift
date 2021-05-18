//
//  Favorites.swift
//  JoseFinalProjectIOS2
//
//  Created by Jose M Arguinzzones on 2021-04-13.
//

import Foundation
import UIKit

struct Favorite: Equatable, Codable{
    var image: Data?
    var title: String?
    var overview: String?
    var releaseDate: String?
    var trailer: String?
    var voteAverage: String?
    var popularity: String?
    
    enum CodingKeys: String, CodingKey {
        case image
        case title
        case overview
        case releaseDate
        case trailer
        case voteAverage
        case popularity
    }
    
    init(){
        
    }
        
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentsDirectory.appendingPathComponent("favorites").appendingPathExtension("plist")
    
    static func saveFavorites(_ favorites: [Favorite]) {
        let propertyListEncoder = PropertyListEncoder()
        let codedFavorites = try? propertyListEncoder.encode(favorites)
        try? codedFavorites?.write(to: archiveURL, options: .noFileProtection)
    }
    
    static func loadFavorites() -> [Favorite]?  {
        guard let codedFavorites = try? Data(contentsOf: archiveURL) else {return nil}
          let propertyListDecoder = PropertyListDecoder()
          return try? propertyListDecoder.decode(Array<Favorite>.self, from: codedFavorites)
    }
}

var favorites = [Favorite]()


