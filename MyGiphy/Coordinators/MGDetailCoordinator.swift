//
//  MGDetailCoordinator.swift
//  MyGiphy
//
//  Created by Chris Chueh on 9/10/19.
//  Copyright © 2019 Tomorrow Ideas. All rights reserved.
//

import UIKit

// MARK: - MGDetailCoordinator

class MGDetailCoordinator: MGCoordinator {
    weak var parentCoordinator: MGMainCoordinator?
    var viewModel: MGGiphyCollectionViewCellViewModel?
    var childCoordinators: [MGCoordinator] = []
    var navigationController: UINavigationController
    
    init(nav: UINavigationController, viewModel: MGGiphyCollectionViewCellViewModel) {
        self.navigationController = nav
        self.viewModel = viewModel
    }
    
    func start() {
        let vc = MGGiphyDetailViewController.instantiate()
        vc.viewModel = viewModel
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
