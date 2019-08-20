//
//  GiphyCell.swift
//  MyGiphy
//
//  Created by Noah Bragg on 8/19/19.
//  Copyright © 2019 Tomorrow Ideas. All rights reserved.
//

import UIKit
import GiphyUISDK

class GiphyCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    var gif: Gif? {
        didSet {
            gifView.loadAsset(at: gif!.downSampleUrl!)
        }
    }
    
    let gifView: GPHMediaView = {
        var mediaView = GPHMediaView()
        return mediaView
    }()
    
    func setupViews() {
        addSubview(gifView)
        
        addConstraintsWithFormat(format: "H:|-0-[v0]-0-|", views: gifView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
