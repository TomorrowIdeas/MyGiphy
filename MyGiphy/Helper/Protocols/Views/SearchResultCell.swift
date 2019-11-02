//
//  SearchResultCell.swift
//  MyGiphy
//
//  Created by Eugene Berezin on 11/1/19.
//  Copyright © 2019 Tomorrow Ideas. All rights reserved.
//

import UIKit
import SDWebImage

class SearchResultCell: UICollectionViewCell {
    
    var viewModel: GiphyPresentable? {
        didSet {
            guard let vm = viewModel else {
                return
            }
            giphyImageView.sd_setImage(with: vm.giphyURL)
    
            
        }
    }
    

    let giphyImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 16
        iv.clipsToBounds = true
        iv.backgroundColor = .white
        return iv
    }()
    
    let giphyLabel: UILabel = {
        let label = UILabel()
        label.text = "Giphy title"
        return label
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(giphyImageView)
        giphyImageView.fillSuperview(padding: .init(top: 0, left: 10, bottom: 0, right: 10))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
