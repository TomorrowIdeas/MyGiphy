//
//  MGGiphyCollectionViewCellViewModel.swift
//  MyGiphy
//
//  Created by Eugene Berezin on 11/1/19.
//  Copyright © 2019 Tomorrow Ideas. All rights reserved.
//

import Foundation
import GiphyCoreSDK
import UIKit

// MARK: - MGGiphyCollectionViewCellViewModel

struct MGGiphyCollectionViewCellViewModel {
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
}

// MARK: - CommentTextViewPresentable

extension MGGiphyCollectionViewCellViewModel: CommentTextViewPresentable {
    var commentTextViewColor: UIColor {
        return .lightGray
    }
    
    var commentTextViewFont: UIFont {
        return .systemFont(ofSize: 12)
    }
}

// MARK: - LabelPresentable

extension MGGiphyCollectionViewCellViewModel: LabelPresentable {
    var title: String? {
        return myGiphy.title
    }
    
    var avatarName: String? {
        return myGiphy.user?.avatarUrl
    }
    
    var username: NSMutableAttributedString? {
        let str = myGiphy.user?.displayName
        
        return str?.createBoldString()
    }
    
    var labelTextColor: UIColor {
        return .black
    }
    
    var labelFont: UIFont {
        return .systemFont(ofSize: 14)
    }
}

// MARK: - GiphyPresentable

extension MGGiphyCollectionViewCellViewModel: GiphyPresentable {
    
    // Fetches the 100px fixed height image designed for mobile app scrolling
    var giphyURL: URL? {
        if let images = myGiphy.images, let size = images.fixedHeightSmall, let gifURL = size.gifUrl {
            let url = URL(string: gifURL)
            
            return url
        }
        
        return URL(string: "")
    }
    
    // File size under 5mb. Display a higher quality image to the user when selected.
    var qualityGiphyURL: URL? {
        if let images = myGiphy.images, let size = images.downsizedMedium, let gifURL = size.gifUrl {
            let url = URL(string: gifURL)
            
            return url
        }
        
        return URL(string: "")
    }
}

