//
//  CommentTextViewPresentable.swift
//  MyGiphy
//
//  Created by Chris Chueh on 9/11/19.
//  Copyright © 2019 Tomorrow Ideas. All rights reserved.
//

import UIKit

protocol CommentTextViewPresentable {
    var commentTextViewPlaceholder: String { get }
    var commentTextViewColor: UIColor { get }
    var commentTextViewBorderColor: CGColor { get }
    var commentTextViewFont: UIFont { get }
    var commentTextViewBackgroundColor: UIColor { get }
}

extension CommentTextViewPresentable {
    var commentTextViewPlaceholder: String {
        return "Write a comment..."
    }
    
    var commentTextViewColor: UIColor {
        return .lightGray
    }
    
    var commentTextViewBorderColor: CGColor {
        return UIColor.lightGray.cgColor
    }
    
    var commentTextViewFont: UIFont {
        return .systemFont(ofSize: 12)
    }
    
    var commentTextViewBackgroundColor: UIColor {
        return .white
    }
}

