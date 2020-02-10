//
//  ExpandingInputViewController.swift
//  MyGiphy
//
//  Created by Joey Nelson on 2/10/20.
//  Copyright © 2020 Tomorrow Ideas. All rights reserved.
//

import UIKit

protocol ExpandingInputDelegate {
    func didInput(text: String, expandingInput: ExpandingInputViewController)
}

class ExpandingInputViewController: UIViewController {
    
    // MARK: Properties
    private let baseView = ExpandingInputView()
    internal var delegate: ExpandingInputDelegate?
    
    // MARK: Lifecycle
    override func loadView() {
        super.loadView()
        view = baseView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(toggleActive))
        baseView.containerView.addGestureRecognizer(tap)
        
        baseView.inputButton.addTarget(self, action: #selector(inputButtonAction), for: .touchUpInside)
    }
    
    @objc func toggleActive() {
        baseView.becomeActive()
        baseView.textField.becomeFirstResponder()
    }
    
    func toggleInactive() {
        baseView.becomeInactive()
        baseView.textField.resignFirstResponder()
    }
    
    @objc func inputButtonAction() {
        guard let text = baseView.textField.text else { return }
        delegate?.didInput(text: text, expandingInput: self)
    }
}
