//
//  MGMainCoordinator.swift
//  MyGiphy
//
//  Created by Chris Chueh on 9/10/19.
//  Copyright © 2019 Tomorrow Ideas. All rights reserved.
//

import UIKit

// MARK: - MGMainCoordinator

final class MGMainCoordinator: NSObject, MGCoordinator {
    var childCoordinators: [MGCoordinator] = []
    var navigationController: UINavigationController
    
    init(nav: UINavigationController) {
        self.navigationController = nav
    }
    
    // Pushes the Giphy list controller onto the stack
    func start() {
        navigationController.delegate = self
        let vc = MGGiphyListViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    // Adds a child coordinator and passes off responsibility to it
    func showDetailsOfGif(vm: MGGiphyCollectionViewCellViewModel) {
        let child = MGDetailCoordinator(nav: navigationController, viewModel: vm)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }
    
    // Remove the child coordinator from the array
    func childDidFinish(_ child: MGCoordinator?) {
        childCoordinators = childCoordinators.filter { $0 !== child }
    }
}

// Utilize the navigation delegate to detect when a view controller is shown
extension MGMainCoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
        // Read the view controller that you are moving from
        guard let fromVC = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }
        
        // Check if our navigation stack already contains the view controller. If it does it means we are pushing another view controller on top
        if navigationController.viewControllers.contains(fromVC) {
            return
        }
        
        // If we reach here, it means we are popping a view controller and can end the coordinator
        if let detailVC = fromVC as? MGGiphyDetailViewController {
            childDidFinish(detailVC.coordinator)
        }
    }
}
