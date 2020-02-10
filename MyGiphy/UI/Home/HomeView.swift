//
//  HomeView.swift
//  MyGiphy
//
//  Created by Joey Nelson on 2/10/20.
//  Copyright © 2020 Tomorrow Ideas. All rights reserved.
//

import UIKit

class HomeView: UIView, ProgrammaticLayoutView {
    
    // MARK: Subviews
    let collectionContainer = UIView()
    let searchContainer = UIView()
    
    // MARK: Stored constraints
    private var searchBottom: NSLayoutConstraint!
    
    // MARK: Initialization
    convenience init() {
        self.init(frame: .zero)
        configureSubviews()
        configureLayout()
    }
    
    // MARK: Configuration methods
    func configureSubviews() {
        backgroundColor = .white
    }
    
    func configureLayout() {
        addAutoLayoutSubview(collectionContainer)
        addAutoLayoutSubview(searchContainer)
        
        collectionContainer.fillSuperview()
        
        searchBottom = searchContainer.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32)
        
        NSLayoutConstraint.activate([
            searchContainer.heightAnchor.constraint(equalToConstant: 60),
            searchContainer.leftAnchor.constraint(equalTo: leftAnchor),
            searchContainer.rightAnchor.constraint(equalTo: rightAnchor),
            searchBottom
        ])
    }
    
    func moveSearchContainer(offset: CGFloat) {
        searchBottom.constant = offset
        
        UIView.animate(withDuration: 0.25) {
            self.layoutIfNeeded()
        }
    }
}
