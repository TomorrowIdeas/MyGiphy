//
//  Server.swift
//  MyGiphy
//
//  Created by Eugene Berezin on 11/1/19.
//  Copyright © 2019 Tomorrow Ideas. All rights reserved.
//



import Foundation
import GiphyCoreSDK


class Service {
    
    static let shared = Service() //Singleton
    func fetchGiphies(searchTerm: String, completion: @escaping ([MGGiphyCollectionViewCellViewModel]) -> ()) {
        
        GiphyCore.configure(apiKey: "BILpI86hmpKxMlmLZ1w8gpWDsmnGi9Y5")
        var viewModels: [MGGiphyCollectionViewCellViewModel] = []
        
        GiphyCore.shared.search(searchTerm, media: .gif, offset: 33, limit: 20, rating: .ratedPG13, lang: .english) { (response, error) in
            if let error = error {
                print(error)
                return
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



