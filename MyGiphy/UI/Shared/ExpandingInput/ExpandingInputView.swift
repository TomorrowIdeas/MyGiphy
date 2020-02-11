//
//  ExpandingInputView.swift
//  MyGiphy
//
//  Created by Joey Nelson on 2/10/20.
//  Copyright © 2020 Tomorrow Ideas. All rights reserved.
//

import UIKit

class ExpandingInputView: UIView, ProgrammaticLayoutView {
    
    // MARK: Subviews
    internal let containerView = UIView()
    internal let inputIcon = UIImageView()
    
    internal let inputButton = UIButton()
    internal let textField = UITextField()
    
    // MARK: Stored constraints
    private var activeConstraints: [NSLayoutConstraint]!
    private var inactiveConstraints: [NSLayoutConstraint]!
    private var sharedConstraints: [NSLayoutConstraint]!
    
    // MARK: Initialization
    convenience init() {
        self.init(frame: .zero)
        configureSubviews()
        configureLayout()
    }
    
    func configureSubviews() {
        containerView.layer.borderColor = UIColor.purple.cgColor
        containerView.layer.borderWidth = 2
        containerView.layer.cornerRadius = 30
        containerView.backgroundColor = .white
        
        inputIcon.contentMode = .scaleAspectFit
        
        inputButton.setTitle("GO", for: .normal)
        inputButton.titleLabel?.font = UIFont(name: "Avenir-BlackOblique", size: 15)
        inputButton.setTitleColor(.black, for: .normal)
        inputButton.backgroundColor = .white
        inputButton.layer.cornerRadius = 25
        
        textField.font = UIFont(name: "Avenir", size: 12)
    }
    
    func configureLayout() {
        addAutoLayoutSubview(containerView)
        addAutoLayoutSubview(inputButton)
        containerView.addAutoLayoutSubview(inputIcon)
        containerView.addAutoLayoutSubview(textField)
        
        inactiveConstraints = [
            containerView.widthAnchor.constraint(equalToConstant: 60),
            containerView.rightAnchor.constraint(equalTo: rightAnchor, constant: -21),
            
            inputButton.leftAnchor.constraint(equalTo: rightAnchor, constant: 15),
        ]
        
        activeConstraints = [
            inputButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -21),
            
            containerView.leftAnchor.constraint(equalTo: leftAnchor, constant: 21),
            containerView.rightAnchor.constraint(equalTo: inputButton.leftAnchor, constant: -12),
        ]
        
        sharedConstraints = [
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            inputButton.widthAnchor.constraint(equalToConstant: 50),
            inputButton.heightAnchor.constraint(equalToConstant: 50),
            inputButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            textField.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5),
            textField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 15),
            textField.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -5),
            textField.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -15),
            
            inputIcon.widthAnchor.constraint(equalToConstant: 24),
            inputIcon.heightAnchor.constraint(equalToConstant: 24),
            inputIcon.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            inputIcon.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
        ]
        
        NSLayoutConstraint.activate(sharedConstraints)
        becomeInactive(animated: false)
    }
    
    func becomeActive(animated: Bool = true) {
        textField.isEnabled = true
        
        NSLayoutConstraint.deactivate(inactiveConstraints)
        NSLayoutConstraint.activate(activeConstraints)
        
        let block = {
            self.layoutIfNeeded()
            self.textField.alpha = 1
            self.inputIcon.alpha = 0
        }
        if animated {
            UIView.animate(withDuration: 0.25) {
                block()
            }
        } else {
            block()
        }
    }
    
    func becomeInactive(animated: Bool = true) {
        textField.isEnabled = false
        
        NSLayoutConstraint.deactivate(activeConstraints)
        NSLayoutConstraint.activate(inactiveConstraints)
        
        let block = {
            self.layoutIfNeeded()
            self.textField.alpha = 0
            self.inputIcon.alpha = 1
        }
        if animated {
            UIView.animate(withDuration: 0.25) {
                block()
            }
        } else {
            block()
        }
    }
}
