//
//  DetailViewController.swift
//  MyGiphy
//
//  Created by Joey Nelson on 2/10/20.
//  Copyright © 2020 Tomorrow Ideas. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: Properties
    private let baseView = DetailView()
    var giph: Giph?
    
    // MARK: Lifecycle
    override func loadView() {
        super.loadView()
        view = baseView
    }
}
