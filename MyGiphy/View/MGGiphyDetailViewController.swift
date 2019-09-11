//
//  MGGiphyDetailViewController.swift
//  MyGiphy
//
//  Created by Chris Chueh on 9/10/19.
//  Copyright © 2019 Tomorrow Ideas. All rights reserved.
//

import UIKit

final class MGGiphyDetailViewController: UIViewController, MGStoryboarded {
    weak var coordinator: DetailCoordinator?
    
    var viewModel: MGGiphyCollectionViewCellViewModel? {
        didSet {
            guard let vm = viewModel else {
                return
            }
            print(vm)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//        coordinator?.didFinishBuying()
//    }
}
