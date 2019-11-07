//
//  RootVC.swift
//  MyGiphy
//
//  Created by Benji Dodgson on 8/16/19.
//  Copyright © 2019 Tomorrow Ideas. All rights reserved.
//

import UIKit

class RootVC: UICollectionViewController {
    var gifs = [Datum]()
    private let reuseIdentifier = "GifCell"
    let gifInteractor = GifInteractor()
    let search = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureSearchBar()
        configureCollectionView()
        fetchGifs()
    }
    
    func configureNavigationBar() {
        title = "MyGiphy"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureCollectionView() {
        collectionView?.backgroundColor = .darkBackground
        collectionView?.contentInset = UIEdgeInsets(top: 23, left: 10, bottom: 10, right: 10)
        let nib = UINib(nibName: reuseIdentifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
        if let layout = collectionView?.collectionViewLayout as? RootViewLayout {
            layout.delegate = self
        }
    }

    
    
    func fetchGifs(of keyword: String = "lain") {
        gifInteractor.fetchGifs(.gifs()) { (gif, error) in
            if let error = error {
                print(error)
            } else {
                let gifs = gif?.data ?? []
                self.gifs = gifs
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
}

extension RootVC: UISearchResultsUpdating {
    func configureSearchBar() {
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Search"
        navigationItem.searchController = search
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        print(text)
    }
    
}

extension RootVC {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gifs.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! GifCell
        cell.configure(with: gifs[indexPath.row])
        return cell
    }
}

extension RootVC : RootViewLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        guard let height = Int(gifs[indexPath.item].images.fixedHeightSmall.height) else { return 100 }
        return CGFloat(height) * 0.15
    }
}
