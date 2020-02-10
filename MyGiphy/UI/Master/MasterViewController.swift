//
//  MasterViewController.swift
//  MyGiphy
//
//  Created by Joey Nelson on 2/10/20.
//  Copyright © 2020 Tomorrow Ideas. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {
    
    // MARK: Properties
    private let baseView = MasterView.init()
    private let homeViewController = HomeViewController()
    private let networkService = GiphyNetworkService()
    
    override func loadView() {
        super.loadView()
        view = baseView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dataProvider = GiphyDataProvider(networkService: networkService)
        homeViewController.dataProvider = dataProvider
        add(childController: homeViewController, toView: baseView.contentView)
    }
}

