//
//  MGStoryboarded.swift
//  MyGiphy
//
//  Created by Chris Chueh on 9/10/19.
//  Copyright © 2019 Tomorrow Ideas. All rights reserved.
//

import UIKit

protocol MGStoryboarded {
    static func instantiate() -> Self
}

extension MGStoryboarded where Self: UIViewController {
    static func instantiate() -> Self {
        let id = String(describing: self)
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
}


