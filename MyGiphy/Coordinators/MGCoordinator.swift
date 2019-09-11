//
//  MGCoordinator.swift
//  MyGiphy
//
//  Created by Chris Chueh on 9/10/19.
//  Copyright © 2019 Tomorrow Ideas. All rights reserved.
//

import UIKit

protocol MGCoordinator: AnyObject {
    var childCoordinators: [MGCoordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
