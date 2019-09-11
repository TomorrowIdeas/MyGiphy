//
//  MGGiphyCollectionViewCell.swift
//  MyGiphy
//
//  Created by Chris Chueh on 9/9/19.
//  Copyright © 2019 Tomorrow Ideas. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

final class MGGiphyCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "MGGiphyCollectionViewCell"
    
    var viewModel: MGGiphyPresentable? {
        didSet {
            guard let vm = viewModel, let url = vm.url else {
                return
            }
    
            titleLabel.text = vm.title
            gifImageView.kf.setImage(with: url)
        }
    }
    
    private let gifImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        initialize()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    override func prepareForReuse() {
        gifImageView.image = nil
    }
    
    // MARK: - Private
    
    private func initialize() {
        self.addSubview(gifImageView)
        
        gifImageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalToSuperview()
//            make.height.equalTo(20)
        }
        
//        titleLabel.snp.makeConstraints { (make) in
//            make.centerX.equalToSuperview()
//            make.width.equalTo(50)
//            make.centerY.equalToSuperview()
//            make.height.equalTo(20)
//        }
    }
}

