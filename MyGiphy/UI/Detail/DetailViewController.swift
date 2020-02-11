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
    var giph: Giph?
    weak var networkService: GiphyNetworkService?
    
    private let baseView = DetailView()
    private var comments: [Comment] = []
    
    // Child controllers
    let expandingInputController = ExpandingInputViewController()
    
    // MARK: Lifecycle
    override func loadView() {
        super.loadView()
        view = baseView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        expandingInputController.delegate = self
        add(childController: expandingInputController, toView: baseView.inputContainer)
        expandingInputController.iconImage = UIImage(named: "add_icon")
        expandingInputController.placeholderText = "Add a comment..."
        
        baseView.commentTable.dataSource = self
        baseView.commentTable.delegate = self
        
        // Load giph into view
        if let giph = giph, let url = URL(string: giph.url) {
            baseView.giphView.kf.setImage(with: url)
        }
        
        // Setup keyboard observers
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - Keyboard Observing
    @objc func keyboardWillHide(_ sender: Notification) {
        guard let userInfo = (sender as NSNotification).userInfo,
            let _ = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size.height
            else { return }
        baseView.moveInputContainer(offset: -20)
    }
    
    @objc func keyboardWillShow(_ sender: Notification) {
        guard let userInfo = (sender as NSNotification).userInfo,
            let keyboardHeight = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size.height
            else { return }
        
        baseView.moveInputContainer(offset: -keyboardHeight - 20)
    }
}

extension DetailViewController: ExpandingInputDelegate {
    func didInput(text: String, expandingInput: ExpandingInputViewController) {
        guard let giph = giph else { return }
        expandingInput.toggleInactive()
        networkService?.createGiphComment(content: text, giphID: giph.id, completion: { [weak self] (comment, error) in
            if let error = error {
                print(error)
            } else {
                self?.comments.append(comment)
                self?.baseView.commentTable.reloadData()
            }
        })
    }
}

extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension DetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as! GiphCommentTableViewCell
        guard let comment = comments[safe: indexPath.row] else { return cell }
        
        cell.commentLabel.text = comment.content
        
        return cell
    }
}
