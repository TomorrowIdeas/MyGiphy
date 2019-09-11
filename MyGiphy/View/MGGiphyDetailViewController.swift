//
//  MGGiphyDetailViewController.swift
//  MyGiphy
//
//  Created by Chris Chueh on 9/10/19.
//  Copyright © 2019 Tomorrow Ideas. All rights reserved.
//

import UIKit
import SnapKit

final class MGGiphyDetailViewController: UIViewController, MGStoryboarded {
    weak var coordinator: DetailCoordinator?
    
    var viewModel: MGGiphyCollectionViewCellViewModel? {
        didSet {
            guard let vm = viewModel else {
                return
            }
            
            detailView.viewModel = vm
        }
    }
    
    private var detailView: MGGiphyDetailView = {
        let view = MGGiphyDetailView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
    }
    
    private func initialize() {
        title = "Details"

        self.view.addSubview(detailView)
        
        detailView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
}
