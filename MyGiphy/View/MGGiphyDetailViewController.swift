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
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .clear
        table.register(MGGiphyCommentCell.self, forCellReuseIdentifier: MGGiphyCommentCell.reuseIdentifier)
        table.tableFooterView = UIView()
        table.delegate = self
        table.dataSource = self
        return table
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
        self.view.addSubview(tableView)
        
        detailView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo((Constants.Screen.height * (2/3)))
        }
        
        tableView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(detailView.snp.bottom)
            make.height.equalTo((Constants.Screen.height * (1/3)))
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin)
        }
    }
}

extension MGGiphyDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
}

extension MGGiphyDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MGGiphyCommentCell.reuseIdentifier, for: indexPath) as! MGGiphyCommentCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
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
