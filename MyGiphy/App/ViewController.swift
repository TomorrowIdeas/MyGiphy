//
//  ViewController.swift
//  MyGiphy
//
//  Created by Benji Dodgson on 8/16/19.
//  Copyright © 2019 Tomorrow Ideas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        
        let networkService = GiphyNetworkService()
        networkService.searchGiphy(with: "hello") { (giphs, error) in
            if let error = error {
                print(error)
            } else {
                print(giphs)
            }
        }
    }
}

