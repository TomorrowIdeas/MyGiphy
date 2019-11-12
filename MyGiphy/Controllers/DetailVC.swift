//
//  DetailVC.swift
//  MyGiphy
//
//  Created by Lahari on 13/11/2019.
//  Copyright © 2019 Tomorrow Ideas. All rights reserved.
//

import UIKit
import FLAnimatedImage

class DetailVC: UIViewController {
    @IBOutlet weak var imageView: FLAnimatedImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var infoLabel: UILabel!
    
    let selectedGif: Datum
    private let reuseIdentifier = "TableViewCell"
    private var comments = [Comment(text: "Present Day Present Time")]
    
    init(selectedGif: Datum) {
        self.selectedGif = selectedGif
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightBackground
        configureNavigationbar()
        configureTableView()
        configureSubViews()
    }
    
    func configureSubViews() {
        guard let imageURL = URL(string: selectedGif.images.downsized.url) else { return }
        do {
            let gifData = try Data(contentsOf: imageURL)
            imageView.animatedImage = FLAnimatedImage(gifData: gifData)
        } catch {
          print(error)
        }
        
        infoLabel.text = "\(selectedGif.slug)"
    }
    
    func configureNavigationbar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addComment))
    }
    
    func configureTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.dataSource = self
    }
    
    @objc func addComment() {
        let ac = UIAlertController(title: "Enter your comment", message: nil, preferredStyle: .alert)
        ac.addTextField()

        let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned ac] _ in
            guard
                let comment = ac.textFields?.first,
                let commentText = comment.text
            else {
                return
            }
            
            self.comments.append(Comment(text: commentText))
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }

        ac.addAction(submitAction)
        present(ac, animated: true)
    }
}

extension DetailVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.textLabel?.text = comments[indexPath.row].text
        return cell
    }
}
