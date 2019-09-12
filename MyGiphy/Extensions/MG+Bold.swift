//
//  MG+Bold.swift
//  MyGiphy
//
//  Created by Chris Chueh on 9/10/19.
//  Copyright © 2019 Tomorrow Ideas. All rights reserved.
//

import UIKit

extension String {
    
    // Creates a bolded string from a string
    func createBoldString() -> NSMutableAttributedString {
        let attributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)]
        let bolded = NSMutableAttributedString(string: self, attributes: attributes)
        
        return bolded
    }
}
