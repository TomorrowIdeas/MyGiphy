//
//  DetailViewController.swift
//  MyGiphy
//
//  Created by Eugene Berezin on 11/1/19.
//  Copyright © 2019 Tomorrow Ideas. All rights reserved.
//

import UIKit
import SDWebImage


class DetailViewController: UIViewController {
    
    let gifImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .red
        iv.layer.cornerRadius = 16
        iv.heightAnchor.constraint(equalToConstant: 250).isActive = true
        iv.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        return iv
    }()
    
    let textField: UITextField = {
        let tf = UITextField()
        tf.heightAnchor.constraint(equalToConstant: 45).isActive = true
        tf.widthAnchor.constraint(equalToConstant: 150).isActive = true
        tf.backgroundColor = #colorLiteral(red: 0.8175396697, green: 0.8175396697, blue: 0.8175396697, alpha: 1)
        tf.layer.cornerRadius =  16
        
        return tf
        
    }()
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.heightAnchor.constraint(equalToConstant: 300).isActive = true
        tv.widthAnchor.constraint(equalToConstant: 150).isActive = true
        tv.backgroundColor = .magenta
        tv.layer.cornerRadius = 16
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        view.addSubview(gifImageView)
        gifImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 100, left: 20, bottom: 0, right: 20))
        view.addSubview(textField)
        textField.anchor(top: gifImageView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 10, left: 20, bottom: 0, right: 20))
        view.addSubview(textView)
        textView.anchor(top: textField.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 10, left: 20, bottom: 0, right: 20))
    }
    

    

}
