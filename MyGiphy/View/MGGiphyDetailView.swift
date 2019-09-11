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

final class MGGiphyDetailView: UIView {
    var viewModel: MGGiphyCollectionViewCellViewModel? {
        didSet {
            guard let vm = viewModel, let url = vm.higherQualityUrl else {
                return
            }
            
            giphyTitle.text = vm.title
            
            (gifImageView.kf.indicator?.view as? UIActivityIndicatorView)?.color = UIColor.black
            gifImageView.kf.indicatorType = .activity
            gifImageView.kf.setImage(with: url)
            
            if let avatar = vm.avatar, let avatarUrl = URL(string: avatar) {
                avatarPicture.kf.setImage(with: avatarUrl)
            } else {
                avatarPicture.image = UIImage(named: "user36")
            }
            
            let noUsernameForGiphy = "Who made this?"
            usernameLabel.attributedText = vm.username != nil ? vm.username : noUsernameForGiphy.createBoldString()
        }
    }
    
    private let giphyTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = label.font.withSize(12)
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        self.addSubview(gifImageView)
        self.addSubview(usernameLabel)
        self.addSubview(giphyTitle)
        self.addSubview(avatarPicture)
        
        avatarPicture.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(90)
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
            make.centerX.equalToSuperview()
            make.top.equalTo(giphyTitle.snp.bottom).offset(15)
            make.width.equalTo(Constants.Screen.width)
            make.height.equalTo(300)
        }
        
        giphyTitle.snp.makeConstraints { (make) in
            make.top.equalTo(usernameLabel.snp.bottom).offset(10)
            make.height.equalTo(40)
            make.left.equalTo(avatarPicture.snp.left)
            make.right.equalToSuperview().offset(-20)
        }
    }
}
