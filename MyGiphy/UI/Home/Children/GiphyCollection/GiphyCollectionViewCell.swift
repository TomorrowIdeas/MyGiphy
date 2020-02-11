//
//  GiphyCollectionViewCell.swift
//  MyGiphy
//
//  Created by Joey Nelson on 2/10/20.
//  Copyright © 2020 Tomorrow Ideas. All rights reserved.
//

import UIKit

class GiphyCollectionViewCell: UICollectionViewCell, ProgrammaticLayoutView {
    
    // MARK: Subviews
    let giphView = UIImageView()
    
    // MARK: Stored constraints
    
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews()
        configureLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configuration methods
    func configureSubviews() {
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 2
    }
    
    func configureLayout() {
        addAutoLayoutSubview(giphView)
        
        NSLayoutConstraint.activate([
            giphView.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            giphView.leftAnchor.constraint(equalTo: leftAnchor, constant: 2),
            giphView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
            giphView.rightAnchor.constraint(equalTo: rightAnchor, constant: -2),
        ])
    }
}
