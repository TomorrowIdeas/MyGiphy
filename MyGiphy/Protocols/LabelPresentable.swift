//
//  LabelPresentable.swift
//  MyGiphy
//
//  Created by Chris Chueh on 9/11/19.
//  Copyright © 2019 Tomorrow Ideas. All rights reserved.
//

import UIKit

protocol LabelPresentable {
    var title: String? { get }
    var avatarName: String? { get }
    var username: NSMutableAttributedString? { get }
    var labelTextColor: UIColor { get }
    var labelFont: UIFont { get }
}

extension LabelPresentable {
    var labelTextColor: UIColor {
        return .black
    }
    
    var labelFont: UIFont {
        return .systemFont(ofSize: 14)
    }
}
