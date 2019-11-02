//
//  DetailViewController.swift
//  MyGiphy
//
//  Created by Eugene Berezin on 11/1/19.
//  Copyright © 2019 Tomorrow Ideas. All rights reserved.
//

import UIKit
import SDWebImage
import GiphyCoreSDK


class DetailViewController: UIViewController {
    var avatarName: String?
    
    var username: NSMutableAttributedString?
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "Label")
        return label
    }()
    
    
    let avatarLabel: UILabel = {
        let label = UILabel()
        label.text = "User name"
        return label
    }()
    
    
    let avatarNameLabel = UILabel()
    
    let gifImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .red
        iv.layer.cornerRadius = 16
        iv.clipsToBounds = true
        iv.heightAnchor.constraint(equalToConstant: 250).isActive = true
        iv.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        return iv
    }()
    
    let textField: UITextField = {
        let tf = UITextField()
        tf.heightAnchor.constraint(equalToConstant: 45).isActive = true
        tf.widthAnchor.constraint(equalToConstant: 270).isActive = true
        tf.backgroundColor = #colorLiteral(red: 0.9454339378, green: 0.9454339378, blue: 0.9454339378, alpha: 1)
        tf.layer.cornerRadius =  16
        
        return tf
        
    }()
    
    let commentTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.heightAnchor.constraint(equalToConstant: 300).isActive = true
        tv.widthAnchor.constraint(equalToConstant: 150).isActive = true
        tv.backgroundColor = #colorLiteral(red: 0.9454339378, green: 0.9454339378, blue: 0.9454339378, alpha: 1)
        tv.layer.cornerRadius = 16
        tv.isEditable = false
        tv.font = UIFont (name: "System", size: 17)
        return tv
    }()
    
    let sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.backgroundColor = UIColor(white: 0.95, alpha: 1)
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        button.heightAnchor.constraint(equalToConstant: 45).isActive = true
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
        return button
    }()
    
    @objc private func handleSend() {
        if let text = textField.text {
            textView.text = text
            textField.text = ""
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Details"
        hideKeyboardWhenTapped()
        configureUI()

       
        
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(gifImageView)
        gifImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 50, left: 20, bottom: 0, right: 20))
        
        gifImageView.addSubview(userNameLabel)
        userNameLabel.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 5, left: 5, bottom: 0, right: 0))
        view.addSubview(textField)
        textField.anchor(top: gifImageView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 20, bottom: 0, right: 0))
        view.addSubview(textView)
        textView.anchor(top: textField.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 10, left: 20, bottom: 0, right: 20))
        view.addSubview(sendButton)
        sendButton.anchor(top: gifImageView.bottomAnchor, leading: nil, bottom: textView.topAnchor, trailing: view.trailingAnchor, padding: .init(top: 10, left: 5, bottom: 10, right: 20))
    }
    
    private func hideKeyboardWhenTapped() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    @objc private func dismissKeyboard() {
        self.view.endEditing(true)
    }
    

    

}
