//
//  ControllerFactory.swift
//  MyGiphy
//
//  Created by Joey Nelson on 2/10/20.
//  Copyright © 2020 Tomorrow Ideas. All rights reserved.
//

import Foundation

/// To be used when creating Home or Detail controllers. Manages dependency injection for the controllers.
class ControllerFactory {
    
    // MARK: Properties
    private var networkService: GiphyNetworkService
    
    init(networkService: GiphyNetworkService) {
        self.networkService = networkService
    }
    
    func createHomeController() -> HomeViewController {
        let homeController = HomeViewController()
        let dataProvider = GiphyDataProvider(networkService: networkService)
        homeController.dataProvider = dataProvider
        homeController.factory = self
        return homeController
    }
    
    func createDetailController(giph: Giph) -> DetailViewController {
        let detailController = DetailViewController()
        detailController.networkService = networkService
        detailController.giph = giph
        return detailController
    }
}
