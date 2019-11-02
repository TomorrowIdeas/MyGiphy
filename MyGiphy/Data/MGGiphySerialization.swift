//
//  MGGiphySerialization.swift
//  MyGiphy
//
//  Created by Eugene Berezin on 11/1/19.
//  Copyright © 2019 Tomorrow Ideas. All rights reserved.
//

import Foundation
import Foundation
import GiphyCoreSDK
import SDWebImage

// MARK: - MGGiphySerialization

final class MGGiphySerialization {
    func searchForGiphy(_ text: String, _ currentTotal: Int, completion: @escaping (([MGGiphyCollectionViewCellViewModel]) -> Void)) {
        
        // Configure our API key
        GiphyCore.configure(apiKey: "totF40WvhWTaFQzaNNl6n0okld9PPFHT")
        
        var viewModels: [MGGiphyCollectionViewCellViewModel] = []
        
        // Text based search for all Giphy GIFs
        GiphyCore.shared.search(text, media: .gif, offset: currentTotal, limit: 25, rating: .ratedPG13, lang: .english) { response, error in
            
            if let error = error as NSError? {
                print(error)
            }
            
            if let response = response, let data = response.data {
                // Map the array of GPHMedia objects into our view models
                viewModels = data.map( { (giphy: GPHMedia) -> MGGiphyCollectionViewCellViewModel in
                    return MGGiphyCollectionViewCellViewModel(withGiphy: giphy)
                })
            }
            
            completion(viewModels)
        }
    }
}
