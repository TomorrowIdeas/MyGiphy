//
//  ViewController.swift
//  MyGiphy
//
//  Created by Benji Dodgson on 8/16/19.
//  Copyright © 2019 Tomorrow Ideas. All rights reserved.
//

import UIKit
import GiphyUISDK
import GiphyCoreSDK
import SDWebImage


class GiphySearchController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    fileprivate let searchCellID = "SearchCellID"
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    
    
    lazy var searchBar = UISearchBar(frame: .zero)
    private var isLoading: Bool = false
    
    // Inject the view models
    var viewModels: [MGGiphyCollectionViewCellViewModel] = [] {
        didSet {
            // Property observer for reloading collection view
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.collectionView.reloadData()
            }
        }
    }
    
    lazy var giphyService: MGGiphySerialization = {
        return MGGiphySerialization()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: searchCellID)
        initialize()
        searchBar.text = "smile"
        fetchGiphys()
        
    }
    
    private func initialize() {
        searchBar.delegate = self
        //searchBar.placeholder.text = "Search for GIFs!
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.titleView = searchBar
        definesPresentationContext = true
    }
    
    private func initializeSearch() {
        // Empty collection view if the search bar has no text
        if searchBar.text == nil || searchBar.text == "" {
            viewModels = []
        } else {
            // Cancel previous requests and throttle as you type
            NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.fetchGiphys), object: searchBar)
            perform(#selector(self.fetchGiphys), with: searchBar, afterDelay: 0.8)
        }
    }
    
    @objc private func fetchGiphys() {
        let currentTotal = viewModels.count
        let text = searchBar.text ?? ""
        
        giphyService.searchForGiphy(text, currentTotal) { vms in
            self.viewModels += vms
            self.isLoading = false
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModels = []
        initializeSearch()
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: searchCellID, for: indexPath) as! SearchResultCell
        let vm = viewModels[indexPath.row]
        cell.viewModel = vm
        return cell
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVc = DetailViewController()
        let vm = viewModels[indexPath.row]
        // Stops search when moving to the next screen
        if searchBar.isFirstResponder {
            searchBar.resignFirstResponder()
        }
        detailVc.gifImageView.sd_setImage(with: vm.giphyURL)
        navigationController?.pushViewController(detailVc, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 350)
    }
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}




extension GiphySearchController {
    // If search text is changing, empty the collection view
    
    
    // If the user presses search on the keyboard
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if viewModels.count == 0 {
            initializeSearch()
        }
        
        searchBar.resignFirstResponder()
    }
}

