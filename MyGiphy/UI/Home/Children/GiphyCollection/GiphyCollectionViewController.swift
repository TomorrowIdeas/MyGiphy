//
//  GiphyCollectionViewController.swift
//  MyGiphy
//
//  Created by Joey Nelson on 2/10/20.
//  Copyright © 2020 Tomorrow Ideas. All rights reserved.
//

import UIKit

class GiphyCollectionViewController: UIViewController {
    
       // MARK: Properties
       private let baseView = GiphyCollectionView()
       
       // MARK: Lifecycle
       override func loadView() {
           super.loadView()
           view = baseView
       }

       override func viewDidLoad() {
           super.viewDidLoad()
       }
}
