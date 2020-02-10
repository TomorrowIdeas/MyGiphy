//
//  GiphyNetworkService.swift
//  MyGiphy
//
//  Created by Joey Nelson on 2/10/20.
//  Copyright © 2020 Tomorrow Ideas. All rights reserved.
//

import Foundation

final class GiphyNetworkService {
    
    // MARK: Properties
    private let giphyAPIKey = "K1EYvB0I7X958MZBcsD0TJE2wCzO67wV"
    private let baseURL = "https://api.giphy.com/v1"
    
    private let defaultSession = URLSession(configuration: .default)
    
    // MARK: Network calls
    internal func searchGiphy(with keyword: String, limit: Int = 24, offset: Int = 0, completion: @escaping (_ giphs: [Giph], _ error: Error?) -> ()) {
        
        guard var urlComponents = URLComponents(string: "\(baseURL)/gifs/search" ) else { return }
        urlComponents.query = "api_key=\(giphyAPIKey)&q=\(keyword)&limit=\(limit)&offset=\(offset)&rating=G&lang=en"
        guard let url = urlComponents.url else { return }
        
        let onError: (_ error: Error) -> () = { error in
            DispatchQueue.main.async {
                print(error)
                completion([], error)
            }
        }
        
        let dataTask = defaultSession.dataTask(with: url) { data, response, error in
            if let err = error {
                onError(err)
            } else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                let decoder = JSONDecoder()
                do {
                    let decodedList = try decoder.decode(GiphySearchResult.self, from: data)
                    DispatchQueue.main.async {
                        completion(decodedList.giphs, nil)
                    }
                } catch {
                    onError(error)
                }
            }
        }
        
        dataTask.resume()
    }
    
    internal func createGiphComment(content: String) {
        
    }
}
