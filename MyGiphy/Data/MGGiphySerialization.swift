//
//  MGGiphySerialization.swift
//  MyGiphy
//
//  Created by Chris Chueh on 9/10/19.
//  Copyright © 2019 Tomorrow Ideas. All rights reserved.
//

import Foundation
import GiphyCoreSDK

final class MGGiphySerialization {
    func searchForGiphy(_ text: String, _ currentTotal: Int, completion: @escaping (([MGGiphyCollectionViewCellViewModel]) -> Void)) {
        var viewModels: [MGGiphyCollectionViewCellViewModel] = []
        
        GiphyCore.shared.search(text, media: .gif, offset: currentTotal, limit: 25, rating: .ratedPG13, lang: .english) { response, error in
            
            if let error = error as NSError? {
                print(error)
            }
            
            if let response = response, let data = response.data {
                viewModels = data.map( { (giphy: GPHMedia) -> MGGiphyCollectionViewCellViewModel in
                    return MGGiphyCollectionViewCellViewModel(withGiphy: giphy)
                })
            }
            
            completion(viewModels)
        }
    }
}
