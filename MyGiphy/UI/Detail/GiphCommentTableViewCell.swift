//
//  GiphCommentTableViewCell.swift
//  MyGiphy
//
//  Created by Joey Nelson on 2/10/20.
//  Copyright © 2020 Tomorrow Ideas. All rights reserved.
//

import UIKit

class GiphCommentTableViewCell: UITableViewCell, ProgrammaticLayoutView {
    
    // MARK: Subviews
    let container = UIView()
    let commentLabel = UILabel()
    
    // MARK: Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureSubviews()
        configureLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureSubviews() {
        container.layer.borderColor = UIColor.black.cgColor
        container.layer.borderWidth = 2
        
        commentLabel.font = UIFont(name: "Avenir", size: 13)
        commentLabel.textColor = .purple
        commentLabel.numberOfLines = 0
        commentLabel.lineBreakMode = .byWordWrapping
    }
    
    func configureLayout() {
        addAutoLayoutSubview(container)
        container.addAutoLayoutSubview(commentLabel)
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            container.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            container.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            container.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            
            commentLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 8),
            commentLabel.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 12),
            commentLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -8),
            commentLabel.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -12),
        ])
    }
}
