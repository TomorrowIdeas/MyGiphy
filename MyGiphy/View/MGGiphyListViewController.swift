//
//  MGGiphyListViewController.swift
//  MyGiphy
//
//  Created by Benji Dodgson on 8/16/19.
//  Copyright © 2019 Tomorrow Ideas. All rights reserved.
//

import UIKit

// MARK: - MGGiphyListViewController

class MGGiphyListViewController: UIViewController, MGStoryboarded {
    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var coordinator: MGMainCoordinator?
    
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
        
        initialize()
        
        // Default search value
        searchBar.text = "corgi"
        fetchGiphys()
        
        hideKeyboardWhenTappedAround()
    }
    
    // Dismiss when tapped outside keyboard and end searching
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        self.searchBar.resignFirstResponder()
    }
    
    // Fetch a list of GIFs and account for offset if using infinite scroll
    @objc private func fetchGiphys() {
        let currentTotal = viewModels.count
        let text = searchBar.text ?? ""
        
        giphyService.searchForGiphy(text, currentTotal) { vms in
            self.viewModels += vms
            self.isLoading = false
        }
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

    private func initialize() {
        searchBar.delegate = self
        searchBar.placeholder = "Search for GIFs!"

        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.titleView = searchBar
        
        definesPresentationContext = true
        
        // Register cell for reuse
        collectionView.register(MGGiphyCollectionViewCell.self, forCellWithReuseIdentifier: MGGiphyCollectionViewCell.reuseIdentifier)
    }
}

extension MGGiphyListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vm = viewModels[indexPath.row]
        
        // Stops search when moving to the next screen
        if searchBar.isFirstResponder {
            searchBar.resignFirstResponder()
        }
        
        // Pass the view model to the coordinator
        coordinator?.showDetailsOfGif(vm: vm)
    }
}

extension MGGiphyListViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MGGiphyCollectionViewCell.reuseIdentifier, for: indexPath) as! MGGiphyCollectionViewCell
        
        let vm = viewModels[indexPath.row]
        
        // Passes the view model forward
        cell.viewModel = vm
        return cell
    }
}

extension MGGiphyListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        // Determine size for each collection cell
        let size = collectionView.calculateSizeForCollectionViewItem(cellsPerRow: 3)
        
        return size
    }
}

extension MGGiphyListViewController: UISearchBarDelegate {
    // If search text is changing, empty the collection view
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModels = []
        initializeSearch()
    }
    
    // If the user presses search on the keyboard
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if viewModels.count == 0 {
            initializeSearch()
        }
        
        searchBar.resignFirstResponder()
    }
}

extension MGGiphyListViewController: UIScrollViewDelegate {
    
    // Loads more GIFs and allows infinite scrolling for the user
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
        let contentOffset = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let boundsHeight = scrollView.bounds.height
        
        guard boundsHeight < contentHeight else {
            return
        }
        
        // Offset is how far you scroll past the contents of the collection view
        let offset = contentOffset - (contentHeight - boundsHeight)
        
        if offset > 100 {
            if !isLoading {
                isLoading = true
                fetchGiphys()
            }
        }
    }
}
