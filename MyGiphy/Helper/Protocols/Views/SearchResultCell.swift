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
        iv.widthAnchor.constraint(equalToConstant: 370).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 250).isActive = true
        iv.layer.cornerRadius = 16
        iv.clipsToBounds = true
        iv.backgroundColor = .magenta
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
        let infoTopStackView = VerticalStackView(arrangedSubviews: [giphyImageView, giphyLabel])
               infoTopStackView.spacing = 12
               infoTopStackView.alignment = .center
               addSubview(infoTopStackView)
               infoTopStackView.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
           }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
