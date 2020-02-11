//
//  DetailView.swift
//  MyGiphy
//
//  Created by Joey Nelson on 2/10/20.
//  Copyright © 2020 Tomorrow Ideas. All rights reserved.
//

import UIKit

import UIKit

class DetailView: UIView, ProgrammaticLayoutView {
    
    // MARK: Subviews
    
    // MARK: Stored constraints
    
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
        
    }
}
