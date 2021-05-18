//
//  Fetch.swift
//  JoseFinalProjectIOS2
//
//  Created by Jose M Arguinzzones on 2021-04-11.
//

import Foundation
import UIKit

class MovieInfoController  {
    
    func fetchMovieInfo(matching query: [String: String], completion: @escaping (Result<[Movie], Error>) -> Void) {
        let baseURL = URL(string:  "https://api.themoviedb.org/3/discover/movie?")!
        
        guard let url = baseURL.withQueries(query) else {
            print("Unable to build URL with supplied queries.")
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            let decoder = JSONDecoder()
            if let data = data{
                do {
               let storeMovies = try decoder.decode(Movie.self, from: data)
                movies = [storeMovies]
                    completion(.success([storeMovies]))
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }
        task.resume()
    }

    enum MovieInfoError: Error, LocalizedError {
        case imageDataMissing
    }

    func fetchImage(from url: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        let baseURL = URL(string:  url)!
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
            urlComponents?.scheme = "https"
        let task = URLSession.shared.dataTask(with: urlComponents!.url!) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                completion(.success(image))
            } else if let error = error {
                completion(.failure(error))
            } else {
                completion(.failure(MovieInfoError.imageDataMissing))
            }
        }

        task.resume()
    }

    func fetchVideo(video id: Int, completion: @escaping ([Any]?) -> Void) {
        let baseURL = URL(string:  "https://api.themoviedb.org/3/movie/\(id)/videos?api_key=8f8358ee1f03c592045af0af375edc2d&language=en-US")!
        let task = URLSession.shared.dataTask(with: baseURL) { (data, response, error) in
            let decoder = JSONDecoder()
            if let data = data,
               let storeVideos = try? decoder.decode(Video.self, from: data) {
                videos = [storeVideos]
                completion([storeVideos])
            } else {
                print("Either no data was returned, or data was not serialized2.")
                completion(nil)
                return
            }
        }
        task.resume()
    }
}

extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.map { URLQueryItem(name: $0.0, value: $0.1) }
        return components?.url
    }
}

