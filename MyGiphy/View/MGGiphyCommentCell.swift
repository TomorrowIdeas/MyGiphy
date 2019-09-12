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
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = label.font.withSize(12)
        return label
    }()
    
    var comment: String? {
        didSet {
            commentLabel.text = comment
        }
    }
    
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
        self.contentView.addSubview(commentLabel)
        
        commentLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-15)
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
}

