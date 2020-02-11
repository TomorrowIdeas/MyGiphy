//
//  GiphyCollectionViewController.swift
//  MyGiphy
//
//  Created by Joey Nelson on 2/10/20.
//  Copyright © 2020 Tomorrow Ideas. All rights reserved.
//

import UIKit
import Kingfisher

class GiphyCollectionViewController: UIViewController {
    
    // MARK: Properties
    private let baseView = GiphyCollectionView()
    
    var giphs = [Giph]() {
        didSet {
            guard let collection = baseView.collection else { return }
            collection.reloadData()
        }
    }
    
    // MARK: Lifecycle
    override func loadView() {
        super.loadView()
        view = baseView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        baseView.collection.dataSource = self
        baseView.collection.delegate = self
    }
}

extension GiphyCollectionViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return giphs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath) as GiphyCollectionViewCell
        let giph = giphs[indexPath.row]
        guard let url = URL(string: giph.thumbnailURL) else { return cell }
        cell.giphView.kf.setImage(with: url)
        return cell
    }
}

extension GiphyCollectionViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}
