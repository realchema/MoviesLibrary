//
//  Video.swift
//  JoseFinalProjectIOS2
//
//  Created by Jose M Arguinzzones on 2021-04-11.
//

import Foundation

struct Video: Codable {
    let id: Int
    let results: [ResultVideo]
}

struct ResultVideo: Codable {
        let id: String?
        let iso_639_1: String?
        let iso_3166_1: String?
        var key: String?
        let name: String??
        let site: String?
        let size: Int?
        let type: String?
        var video_url: String?{
          return "https://www.youtube.com/embed/" + key!
       
        }
}

var videos = [Video]()
