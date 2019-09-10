//
//  MGGiphyCollectionViewCellViewModel.swift
//  MyGiphy
//
//  Created by Chris Chueh on 9/9/19.
//  Copyright © 2019 Tomorrow Ideas. All rights reserved.
//

import Foundation
import GiphyCoreSDK

protocol MGGiphyPresentable {
    var type: GPHMediaType { get }
    var id: String { get }
    var title: String? { get }
    var url: URL? { get }
}

struct MGGiphyCollectionViewCellViewModel: MGGiphyPresentable {
    private let myGiphy: GPHMedia
    
    init(withGiphy giphy: GPHMedia) {
        self.myGiphy = giphy
    }
    
    var type: GPHMediaType {
        return myGiphy.type
    }
    
    var id: String {
        return myGiphy.id
    }
    
    var title: String? {
        return myGiphy.title
    }
    
    var url: URL? {
        if let images = myGiphy.images, let size = images.fixedHeightSmall, let gifURL = size.gifUrl {
            let url = URL(string: gifURL)
            
            return url
        }
        
        return URL(string: "")
    }
}
