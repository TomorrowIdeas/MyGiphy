//
//  MGGiphyDetailView.swift
//  MyGiphy
//
//  Created by Chris Chueh on 9/10/19.
//  Copyright © 2019 Tomorrow Ideas. All rights reserved.
//

import UIKit
import Kingfisher
import SnapKit

// MARK: - MGGiphyDetailView

final class MGGiphyDetailView: UIView {
    var viewModel: MGGiphyCollectionViewCellViewModel? {
        didSet {
            guard let vm = viewModel, let url = vm.higherQualityUrl else {
                return
            }
            
            // Set the title of the GIF
            giphyTitle.text = vm.title
            
            // Display the owner's username for the GIF
            let noUsernameForGiphy = "Who made this?"
            usernameLabel.attributedText = vm.username != nil ? vm.username : noUsernameForGiphy.createBoldString()
            
            // Display the owner's avatar
            if let avatar = vm.avatar, let avatarUrl = URL(string: avatar) {
                avatarPicture.kf.setImage(with: avatarUrl)
            } else {
                avatarPicture.image = UIImage(named: "user36")
            }
            
            // Set the image using Kingfisher
            setupGiphyGifWithCache(url: url)
        }
    }
    
    private let giphyTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = label.font.withSize(14)
        return label
    }()
    
    private let gifImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private let avatarPicture: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.layer.masksToBounds = true
        return view
    }()
    
    private let commentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Comments:"
        label.font = label.font.withSize(14)
        return label
    }()
    
    let commentBox: UITextView = {
        let view = UITextView()
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 1.0
        view.layer.cornerRadius = 15
        view.text = "Write a comment..."
        view.textColor = UIColor.lightGray
        view.contentInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        view.font = view.font?.withSize(14)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func setupGiphyGifWithCache(url: URL) {
        
        // Display activity indicator. When complete, load image with fade-in animation.
        gifImageView.kf.indicatorType = .activity
        gifImageView.kf.setImage(
            with: url,
            options: [
                .transition(.fade(1)),
            ])
    }

    private func initialize() {
        self.addSubview(gifImageView)
        self.addSubview(usernameLabel)
        self.addSubview(giphyTitle)
        self.addSubview(avatarPicture)
        self.addSubview(commentLabel)
        self.addSubview(commentBox)

        avatarPicture.snp.makeConstraints { (make) in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.topMargin).offset(20)
            make.left.equalToSuperview().offset(20)
            make.width.height.equalTo(30)
        }
        
        usernameLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(avatarPicture.snp.centerY)
            make.height.equalTo(20)
            make.left.equalTo(avatarPicture.snp.right).offset(10)
            make.right.equalToSuperview().offset(-20)
        }
        
        gifImageView.snp.makeConstraints { (make) in
            make.top.equalTo(giphyTitle.snp.bottom).offset(10)
            make.width.equalTo(Constants.Screen.width)
        }
        
        giphyTitle.snp.makeConstraints { (make) in
            make.top.equalTo(usernameLabel.snp.bottom)
            make.height.equalTo(40)
            make.left.equalTo(avatarPicture.snp.left)
            make.right.equalToSuperview().offset(-20)
        }
        
        commentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(gifImageView.snp.bottom).offset(10)
            make.left.equalTo(avatarPicture.snp.left)
            make.height.equalTo(30)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        commentBox.snp.makeConstraints { (make) in
            make.bottom.equalTo(commentLabel.snp.bottom)
            make.left.equalTo(commentLabel.snp.right).offset(10)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(30)
        }
    }
}
