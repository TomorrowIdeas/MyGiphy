//
//  MasterView.swift
//  MyGiphy
//
//  Created by Joey Nelson on 2/10/20.
//  Copyright © 2020 Tomorrow Ideas. All rights reserved.
//

import UIKit

class MasterView: UIView, ProgrammaticLayoutView {
    
    // MARK: Subviews
    var contentView = UIView()
    
    // MARK: Initialization
    convenience init() {
        self.init(frame: .zero)
        configureSubviews()
        configureLayout()
    }
    
    func configureSubviews() {}
    
    func configureLayout() {
        addAutoLayoutSubview(contentView)
        contentView.fillSuperview()
    }
}
