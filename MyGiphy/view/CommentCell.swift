//
//  GiphyCell.swift
//  MyGiphy
//
//  Created by Noah Bragg on 8/19/19.
//  Copyright © 2019 Tomorrow Ideas. All rights reserved.
//

import UIKit

class CommentCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    var comment: String? {
        didSet {
            textView.text = comment
        }
    }
    
    let textView: UITextView = {
        let textView = UITextView()
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = ""
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        textView.textColor = UIColor.white
        textView.backgroundColor = UIColor(displayP3Red: 70/255, green: 156/255, blue: 141/255, alpha: 1)
        textView.layer.cornerRadius = 10
        return textView
    }()
    
    func setupViews() {
        addSubview(textView)
        
        //Add constraint
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: textView)
        addConstraintsWithFormat(format: "V:|-0-[v0]-0-|", views: textView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
