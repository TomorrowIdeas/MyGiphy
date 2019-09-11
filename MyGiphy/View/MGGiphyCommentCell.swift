//
//  MGGiphyCommentCell.swift
//  MyGiphy
//
//  Created by Chris Chueh on 9/11/19.
//  Copyright © 2019 Tomorrow Ideas. All rights reserved.
//

import UIKit

final class MGGiphyCommentCell: UITableViewCell {
    static let reuseIdentifier = "MGGiphyCommentCell"
    
    private let commentLabel: UILabel = {
        let label = UILabel()
        label.text = "Wow this Giphy is amazing!! where did you find it?"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = label.font.withSize(12)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    // MARK: - Private
    
    private func initialize() {
        self.addSubview(commentLabel)
        
        commentLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
            make.height.equalTo(20)
        }
    }
}

