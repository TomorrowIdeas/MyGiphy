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
    private var searchKeyword: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureSearchController()
        configureCollectionView()
        spinnerPresenter.addSpinner()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchGifs()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }

    func configureNavigationBar() {
        title = "MyGiphy"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
    }
    
    func configureCollectionView() {
        collectionView.isScrollEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView?.backgroundColor = .darkBackground
        collectionView?.contentInset = UIEdgeInsets(top: 23, left: 10, bottom: 10, right: 10)
        let nib = UINib(nibName: reuseIdentifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
        if let layout = collectionView?.collectionViewLayout as? RootViewLayout {
            layout.delegate = self
        }
        
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "Footer")
        (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.footerReferenceSize = CGSize(width: collectionView.bounds.width, height: 50)
    }
    
    func configureSearchController() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.delegate = self
        definesPresentationContext = true
    }
    
//    TODO: Figure out why this collection view is not reloading with self.gifs += newGifs
    
    func fetchGifs(keyword: String = "lain", limit: Int = 15, offset: Int = 0) {
        gifInteractor.fetchGifs(.gifs(keyword: keyword, limit: limit, offset: offset)) { (gif, error) in
            if let _ = error {
//                TODO: Add error presenter
            } else {
                self.offset += limit
                guard let newGifs = gif?.data else { return }
                guard let paginationData = gif?.pagination else { return }
                
                if paginationData.totalCount / self.offset > 1 {
                    self.gifs = newGifs
                }
                
                DispatchQueue.main.async {
                  self.collectionView.reloadData()
                  self.spinnerPresenter.removeSpinner()
                }
            }
        }
    }
}

extension RootVC {
//    TODO: Add prefetching
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(gifs.count)
        return gifs.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! GifCell
          cell.configure(with: gifs[indexPath.row])
          return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == gifs.count - 1 {
            if let keyword = searchKeyword {
                fetchGifs(keyword: keyword, limit: 15, offset: offset)
            } else {
                fetchGifs(limit: 15, offset: offset)
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailVC(selectedGif: gifs[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
    
//    TODO: Add activity indicater to footer
    
}

extension RootVC : RootViewLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        guard let height = Int(gifs[indexPath.item].images.fixedHeightSmall.height) else { return 100 }
        return CGFloat(height)
    }
}

extension RootVC: UISearchControllerDelegate, UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        searchKeyword = text
        spinnerPresenter.addSpinner()
        fetchGifs(keyword: text)
        searchController.isActive = false
    }
}
