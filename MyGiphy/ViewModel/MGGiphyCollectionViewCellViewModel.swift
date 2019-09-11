//
//  MGGiphyCollectionViewCellViewModel.swift
//  MyGiphy
//
//  Created by Chris Chueh on 9/9/19.
//  Copyright © 2019 Tomorrow Ideas. All rights reserved.
//

import UIKit
import GiphyCoreSDK

protocol MGGiphyPresentable {
    var type: GPHMediaType { get }
    var id: String { get }
    var title: String? { get }
    var url: URL? { get }
    var username: NSMutableAttributedString? { get }
    var avatar: String? { get }
    var higherQualityUrl: URL? { get }
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
    
    var avatar: String? {
        return myGiphy.user?.avatarUrl
    }
    
    var username: NSMutableAttributedString? {
        let str = myGiphy.user?.displayName
        
        return str?.createBoldString()
    }
    
    var url: URL? {
        if let images = myGiphy.images, let size = images.fixedHeightSmall, let gifURL = size.gifUrl {
            let url = URL(string: gifURL)
            
            return url
        }
        
        return URL(string: "")
    }
    
    var higherQualityUrl: URL? {
        if let images = myGiphy.images, let size = images.downsizedMedium, let gifURL = size.gifUrl {
            let url = URL(string: gifURL)
            
            return url
        }
        
        return URL(string: "")
    }
}
