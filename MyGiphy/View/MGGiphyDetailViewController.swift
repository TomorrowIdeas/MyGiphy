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
        hideKeyboardWhenTappedAround()
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    private func resetTextViewPlaceHolder() {
        detailView.commentBox.text = "Write a comment..."
        detailView.commentBox.textColor = UIColor.lightGray
    }
    
    private func initialize() {
        title = "Details"
        detailView.commentBox.delegate = self
        self.view.addSubview(detailView)
        
        
        detailView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
}

extension MGGiphyDetailViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        textView.textColor = .black
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        resetTextViewPlaceHolder()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        print(textView.text)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        
        return true
    }
}
