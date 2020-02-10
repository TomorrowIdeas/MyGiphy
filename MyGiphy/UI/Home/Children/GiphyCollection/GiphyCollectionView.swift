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
    
    
    // MARK: Initialization
    convenience init() {
        self.init(frame: .zero)
        configureSubviews()
        configureLayout()
    }
    
    func configureSubviews() {}
    
    func configureLayout() {
        
    }
}
