//
//  GiphyCell.swift
//  MyGiphy
//
//  Created by Noah Bragg on 8/19/19.
//  Copyright © 2019 Tomorrow Ideas. All rights reserved.
//

import UIKit

class GiphyCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    var gif: Gif? {
        didSet {
            gifView.image = nil
            gifView.image = UIImage.gifImageWithURL(gif!.downSampleUrl!)
//            gifView.image = UIImage
            
//            thumbnailImageView.image = UIImage(named: (video?.thumbnailImageName)!)
//
//            if let profileImageName = video?.channel?.profileImageName {
//                userProfileImageView.image = UIImage(named: profileImageName)
//            }
            
            
        }
    }
    
    let gifView: UIImageView = {
        let imageView = UIImageView(image: nil)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    func setupViews() {
        addSubview(gifView)
        
        addConstraintsWithFormat(format: "H:|-0-[v0]-0-|", views: gifView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
