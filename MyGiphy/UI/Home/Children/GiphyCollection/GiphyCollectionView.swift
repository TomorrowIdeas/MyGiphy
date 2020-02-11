//
//  GiphyCollectionView.swift
//  MyGiphy
//
//  Created by Joey Nelson on 2/10/20.
//  Copyright © 2020 Tomorrow Ideas. All rights reserved.
//

import UIKit

class GiphyCollectionView: UIView, ProgrammaticLayoutView {
    
    // MARK: Subviews
    var collection: UICollectionView!
    
    // MARK: Initialization
    convenience init() {
        self.init(frame: .zero)
        configureSubviews()
        configureLayout()
    }
    
    func configureSubviews() {
        backgroundColor = .white
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 15
        
        collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(GiphyCollectionViewCell.self)
        collection.backgroundColor = .white
        collection.showsVerticalScrollIndicator = false
        collection.contentInset = UIEdgeInsets(top: 32, left: 0, bottom: 72, right: 0)
    }
    
    func configureLayout() {
        addAutoLayoutSubview(collection)
        
        NSLayoutConstraint.activate([
            collection.topAnchor.constraint(equalTo: safeTopAnchor),
            collection.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            collection.bottomAnchor.constraint(equalTo: safeBottomAnchor),
            collection.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
        ])
    }
}
