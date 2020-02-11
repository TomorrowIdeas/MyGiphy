//
//  HomeViewController.swift
//  MyGiphy
//
//  Created by Joey Nelson on 2/10/20.
//  Copyright © 2020 Tomorrow Ideas. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: Properties
    private let baseView = HomeView()
    
    // Child controllers
    let expandingInputController = ExpandingInputViewController()
    let collectionController = GiphyCollectionViewController()
    
    // Data
    internal var dataProvider: GiphyDataProvider?
    
    // MARK: Lifecycle
    override func loadView() {
        super.loadView()
        view = baseView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add Children
        collectionController.delegate = self
        add(childController: collectionController, toView: baseView.collectionContainer)
        
        expandingInputController.delegate = self
        add(childController: expandingInputController, toView: baseView.searchContainer)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - Keyboard Observing
    @objc func keyboardWillHide(_ sender: Notification) {
        guard let userInfo = (sender as NSNotification).userInfo,
            let _ = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size.height
            else { return }
        baseView.moveSearchContainer(offset: -20)
    }
    
    @objc func keyboardWillShow(_ sender: Notification) {
        guard let userInfo = (sender as NSNotification).userInfo,
            let keyboardHeight = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size.height
            else { return }
        
        baseView.moveSearchContainer(offset: -keyboardHeight - 20)
    }
}

extension HomeViewController: GiphyCollectionDelegate {
    func didSelect(giph: Giph, controller: GiphyCollectionViewController) {
        let detailVC = DetailViewController()
        present(detailVC, animated: true)
    }
    
    func collectionDidBeginScrolling(controller: GiphyCollectionViewController) {
        expandingInputController.toggleInactive()
    }
}

extension HomeViewController: ExpandingInputDelegate {
    func didInput(text: String, expandingInput: ExpandingInputViewController) {
        expandingInput.toggleInactive()
        dataProvider?.search(withText: text, completion: { [weak self] (giphs, error) in
            if let error = error {
                print(error)
            } else {
                self?.collectionController.giphs = giphs
            }
        })
    }
}
