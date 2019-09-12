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

// MARK: - MGGiphyCollectionViewCell

final class MGGiphyCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "MGGiphyCollectionViewCell"

    var viewModel: GiphyPresentable? {
        didSet {
            guard let vm = viewModel else {
                return
            }
            
            configure(with: vm)
        }
    }
    
    private let gifImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
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
    
    func configure(with themedViewModel: GiphyPresentable?) {
        guard let vm = themedViewModel, let url = vm.giphyURL else { return }

        // Uses Kingfisher to cache the image
        gifImageView.kf.setImage(with: url)
    }
    
    // MARK: - Private
    
    private func initialize() {
        self.addSubview(gifImageView)
        
        gifImageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
}

