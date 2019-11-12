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
    private var offset: Int = 0
    private let reuseIdentifier = "GifCell"
    let gifInteractor = GifInteractor()
    let searchController = UISearchController(searchResultsController: nil)
    lazy var spinnerPresenter = SpinnerPresenter(hasDimView: true, spinnerStyle: .whiteLarge)

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureSearchController()
        configureCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        spinnerPresenter.addSpinner()
        fetchGifs()
    }

    func configureNavigationBar() {
        title = "MyGiphy"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
    }
    
    func configureCollectionView() {
        collectionView.isPagingEnabled = true
        collectionView?.backgroundColor = .darkBackground
        collectionView?.contentInset = UIEdgeInsets(top: 23, left: 10, bottom: 10, right: 10)
        let nib = UINib(nibName: reuseIdentifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
        if let layout = collectionView?.collectionViewLayout as? RootViewLayout {
            layout.delegate = self
        }
    }
    
    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.delegate = self
        definesPresentationContext = true
    }
    
    func fetchGifs(keyword: String = "lain", limit: Int = 15, offset: Int = 0) {
        gifInteractor.fetchGifs(.gifs(keyword: keyword, limit: limit, offset: offset)) { (gif, error) in
            if let error = error {
                print(error)
            } else {
                self.offset += 15
                guard let newGifs = gif?.data else { return }
                guard let paginationData = gif?.pagination else { return }
                
                if paginationData.totalCount / self.offset > 1 {
                    self.gifs.append(contentsOf: newGifs)
                    DispatchQueue.main.async {
                      self.collectionView.reloadData()
                      self.spinnerPresenter.removeSpinner()
                    }
                }
            }
        }
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
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == gifs.count - 2 {
            fetchGifs( limit: 15, offset: offset)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailVC(selectedGif: gifs[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension RootVC : RootViewLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        guard let height = Int(gifs[indexPath.item].images.fixedHeightSmall.height) else { return 100 }
        return CGFloat(height)
    }
}


extension RootVC: UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        print(text)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        spinnerPresenter.addSpinner()
        fetchGifs(keyword: text)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       guard let text = searchBar.text else { return }
       if text.isEmpty {
          print("")
       }
    }
}
