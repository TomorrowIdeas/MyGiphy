//
//  DetailViewController.swift
//  MyGiphy
//
//  Created by Noah Bragg on 8/19/19.
//  Copyright © 2019 Tomorrow Ideas. All rights reserved.
//

import UIKit
import Foundation
import GiphyUISDK

class DetailViewController: UIViewController {
    var gif: Gif
    var gifDataStore: GifDatastore
    
    init(gif: Gif) {
        self.gif = gif
        gifDataStore = GifDatastore.getInstance()
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Detail View"
        view.backgroundColor = UIColor.white
    }
    
    lazy var commentsView: CommentsView = {
        let cv = CommentsView(gifId: self.gif.id)
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    @objc func addComment() {
        gifDataStore.addComment(gifId: gif.id, comment: newComment.text)
        commentsView.refresh()
    }
    
    let addCommentButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(displayP3Red: 70/255, green: 97/255, blue: 156/255, alpha: 1)
        button.setTitle("Add\nComment", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel!.font = UIFont.systemFont(ofSize: 12)
        button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        button.titleLabel?.textAlignment = NSTextAlignment.center
        button.layer.cornerRadius = 10
        return button
    }()
    
    let newComment: UITextView = {
        let textView = UITextView()
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "New Comment Here"
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        textView.textColor = UIColor.black
        textView.backgroundColor = UIColor(displayP3Red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        textView.isEditable = true
        return textView
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        let gifView: GPHMediaView = {
            let mediaView = GPHMediaView()
            mediaView.loadAsset(at: gif.originalUrl!)
            return mediaView
        }()
        
        view.addSubview(gifView)
        view.addSubview(newComment)
        view.addSubview(addCommentButton)
        view.addSubview(commentsView)
        
        addCommentButton.addTarget(self, action: #selector(addComment), for: .touchUpInside)
        
        //gifview constraints
        view.addConstraint(NSLayoutConstraint(item: gifView, attribute: .top, relatedBy: .equal, toItem: self.topLayoutGuide, attribute: .bottom, multiplier: 1, constant: 0))

        view.addConstraintsWithFormat(format: "H:|-0-[v0]-0-|", views: gifView)
        
        //newComment constraint
        view.addConstraint(NSLayoutConstraint(item: newComment, attribute: .top, relatedBy: .equal, toItem: gifView, attribute: .bottom, multiplier: 1, constant: 8))
        view.addConstraint(NSLayoutConstraint(item: newComment, attribute: .height, relatedBy: .equal, toItem: newComment, attribute: .height, multiplier: 0, constant: 75))
        view.addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: newComment)
        
        //addComment Button
        view.addConstraint(NSLayoutConstraint(item: addCommentButton, attribute: .top, relatedBy: .equal, toItem: gifView, attribute: .bottom, multiplier: 1, constant: 8))
        view.addConstraint(NSLayoutConstraint(item: addCommentButton, attribute: .height, relatedBy: .equal, toItem: newComment, attribute: .height, multiplier: 0, constant: 75))
        view.addConstraintsWithFormat(format: "H:[v0(75)]-16-|", views: addCommentButton)
        
        //commentsView constraints
        commentsView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        commentsView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        //        commentsView.topAnchor.constraint(equalTo: view.topAnchor, constant: 300).isActive = true
        view.addConstraint(NSLayoutConstraint(item: commentsView, attribute: .top, relatedBy: .equal, toItem: newComment, attribute: .bottom, multiplier: 1, constant: 8))
        commentsView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        view.addConstraint(NSLayoutConstraint(item: commentsView, attribute: .bottom, relatedBy: .equal, toItem: self.bottomLayoutGuide, attribute: .top, multiplier: 1, constant: 0))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
