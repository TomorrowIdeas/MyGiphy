//
//  UIViewController+Children.swift
//  MyGiphy
//
//  Created by Joey Nelson on 2/10/20.
//  Copyright © 2020 Tomorrow Ideas. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func add(childController: UIViewController, toView containerView: UIView? = nil) {
        childController.willMove(toParent: self)
        addChild(childController)
        childController.didMove(toParent: self)
        
        if let containerView = containerView {
          containerView.addAutoLayoutSubview(childController.view)
          childController.view.fillSuperview()
        }
    }
}
