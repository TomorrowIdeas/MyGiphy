//
//  MainCoordinator.swift
//  MyGiphy
//
//  Created by Chris Chueh on 9/10/19.
//  Copyright © 2019 Tomorrow Ideas. All rights reserved.
//

import UIKit
import GiphyCoreSDK
 
class MainCoordinator: NSObject, MGCoordinator {
    var childCoordinators: [MGCoordinator] = []
    var navigationController: UINavigationController
    
    init(nav: UINavigationController) {
        self.navigationController = nav
    }
    
    func start() {
        navigationController.delegate = self
        let vc = MGGiphyListViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func showDetailsOfGif(vm: MGGiphyCollectionViewCellViewModel) {
        let child = DetailCoordinator(nav: navigationController, viewModel: vm)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }
    
    func childDidFinish(_ child: MGCoordinator?) {
        childCoordinators = childCoordinators.filter { $0 !== child }
    }
}

extension MainCoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
        guard let fromVC = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }
        
        if navigationController.viewControllers.contains(fromVC) {
            return
        }
        
        if let detailVC = fromVC as? MGGiphyDetailViewController {
            childDidFinish(detailVC.coordinator)
        }
    }
}
