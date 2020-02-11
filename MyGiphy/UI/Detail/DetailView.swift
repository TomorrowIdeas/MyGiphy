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
    let giphView = UIImageView()
    let commentTable = UITableView()
    let inputContainer = UIView()
    
    // MARK: Stored constraints
    private var inputBottom: NSLayoutConstraint!
    
    // MARK: Initialization
    convenience init() {
        self.init(frame: .zero)
        configureSubviews()
        configureLayout()
    }
    
    // MARK: Configuration methods
    func configureSubviews() {
        backgroundColor = .white
        
        giphView.layer.borderColor = UIColor.black.cgColor
        giphView.layer.borderWidth = 2
        
        commentTable.register(GiphCommentTableViewCell.self, forCellReuseIdentifier: "commentCell")
        commentTable.showsVerticalScrollIndicator = false
        commentTable.separatorStyle = .none
    }
    
    func configureLayout() {
        addAutoLayoutSubview(giphView)
        addAutoLayoutSubview(commentTable)
        addAutoLayoutSubview(inputContainer)
        
        inputBottom = inputContainer.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32)
        
        let imageSize = UIScreen.main.bounds.width * 0.85
        
        NSLayoutConstraint.activate([
            giphView.topAnchor.constraint(equalTo: safeTopAnchor, constant: 24),
            giphView.centerXAnchor.constraint(equalTo: centerXAnchor),
            giphView.heightAnchor.constraint(equalToConstant: imageSize),
            giphView.widthAnchor.constraint(equalToConstant: imageSize),
            
            commentTable.topAnchor.constraint(equalTo: giphView.bottomAnchor),
            commentTable.leftAnchor.constraint(equalTo: leftAnchor),
            commentTable.bottomAnchor.constraint(equalTo: bottomAnchor),
            commentTable.rightAnchor.constraint(equalTo: rightAnchor),
            
            inputContainer.heightAnchor.constraint(equalToConstant: 60),
            inputContainer.leftAnchor.constraint(equalTo: leftAnchor),
            inputContainer.rightAnchor.constraint(equalTo: rightAnchor),
            inputBottom
        ])
    }
    
    func moveInputContainer(offset: CGFloat) {
        inputBottom.constant = offset
        
        UIView.animate(withDuration: 0.25) {
            self.layoutIfNeeded()
        }
    }
}
