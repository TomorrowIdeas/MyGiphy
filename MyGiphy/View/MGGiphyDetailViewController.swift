//
//  MGGiphyDetailViewController.swift
//  MyGiphy
//
//  Created by Chris Chueh on 9/10/19.
//  Copyright © 2019 Tomorrow Ideas. All rights reserved.
//

import UIKit
import SnapKit

// MARK: - MGGiphyDetailViewController

final class MGGiphyDetailViewController: UIViewController, MGStoryboarded {
    weak var coordinator: MGDetailCoordinator?
    private var isCommenting: Bool = false

    // List of comments for the Giphy GIF. Scrolls to last row when comment is added.
    private var comments: [String] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self else { return }
                
                strongSelf.tableView.reloadData()
                let lastIndex = IndexPath(row: strongSelf.comments.count - 1, section: 0)
                strongSelf.tableView.scrollToRow(at: lastIndex, at: .bottom, animated: true)
            }
        }
    }
    
    // Inject the view model
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
    
    // Adds a tap gesture when tapped outside of the keyboard
    private func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    // Insert placeholder if user is not commenting
    private func resetTextViewPlaceHolder() {
        isCommenting = false
        detailView.commentBox.text = "Write a comment..."
        detailView.commentBox.textColor = UIColor.lightGray
    }
    
    private func initialize() {
        title = "Details"
        detailView.commentBox.delegate = self
        
        // Dynamic sizing of table view cells based on comment size
        tableView.estimatedRowHeight = 40
        tableView.rowHeight = UITableView.automaticDimension
        
        self.view.addSubview(detailView)
        self.view.addSubview(tableView)

        detailView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(detailView.snp.bottom)
            make.height.equalTo((Constants.Screen.height * (1/3)))
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin).offset(-10)
        }
    }
}

// MARK: - UITableViewDelegate

extension MGGiphyDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}

// MARK: - UITableViewDataSource

extension MGGiphyDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MGGiphyCommentCell.reuseIdentifier, for: indexPath) as! MGGiphyCommentCell
        
        cell.comment = comments[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

// MARK: - UITextViewDelegate

extension MGGiphyDetailViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if !isCommenting {
            textView.text = ""
            textView.textColor = .black
            isCommenting = true
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            resetTextViewPlaceHolder()
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        // If the return button is pressed, add the comment to the table and reset text view
        if text == "\n" {
            if textView.text != "" {
                comments.append(textView.text)
            }
            
            textView.text = ""
            textView.resignFirstResponder()
            
            return false
        }
        
        return true
    }
}
