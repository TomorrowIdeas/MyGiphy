//
//  MGGiphyListViewController.swift
//  MyGiphy
//
//  Created by Benji Dodgson on 8/16/19.
//  Copyright © 2019 Tomorrow Ideas. All rights reserved.
//

import UIKit
import GiphyUISDK
import GiphyCoreSDK

class MGGiphyListViewController: UIViewController, MGStoryboarded {
    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var coordinator: MainCoordinator?
    lazy var searchBar = UISearchBar(frame: .zero)
    private var isLoading: Bool = false
    
    var viewModels: [MGGiphyCollectionViewCellViewModel] = [] {
        didSet {
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

        // Do any additional setup after loading the view.
        GiphyCore.configure(apiKey: "GPAA4CpNkEmIakNtPMQAVVUwmEHv7gyT")
        initialize()
        hideKeyboardWhenTappedAround()
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        self.searchBar.resignFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    func searchWithOffset(_ text: String) {
        let currentTotal = viewModels.count
        
        giphyService.searchForGiphy(text, currentTotal) { vms in
            self.viewModels += vms
            self.isLoading = false
        }
    }
    
    @objc private func fetchGiphys(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            searchWithOffset(text)
        }
    }
    
    private func initializeSearch() {
        if searchBar.text == nil || searchBar.text == "" {
            viewModels = []
        } else {
            NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.fetchGiphys(_:)), object: searchBar)
            perform(#selector(self.fetchGiphys(_:)), with: searchBar, afterDelay: 0.8)
        }
    }
    
    private func initialize() {
        searchBar.delegate = self
        searchBar.placeholder = "Search for GIFs!"
        
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.titleView = searchBar
        
        definesPresentationContext = true
        
        collectionView.register(MGGiphyCollectionViewCell.self, forCellWithReuseIdentifier: MGGiphyCollectionViewCell.reuseIdentifier)
    }
}

extension MGGiphyListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vm = viewModels[indexPath.row]
        
        if searchBar.isFirstResponder {
            searchBar.resignFirstResponder()
        }
        
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
        
        cell.viewModel = vm
        return cell
    }
}

extension MGGiphyListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellsPerRow = 3
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let space = layout.sectionInset.left + layout.sectionInset.right + (layout.minimumInteritemSpacing * CGFloat(cellsPerRow - 1))
        
        let size = Int((collectionView.bounds.width - space) / CGFloat(cellsPerRow))
        return CGSize(width: size, height: 100)
    }
}

extension MGGiphyListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModels = []
        initializeSearch()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        initializeSearch()
        
        searchBar.resignFirstResponder()
    }
}

extension MGGiphyListViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
        let contentOffset = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let boundsHeight = scrollView.bounds.height
        
        guard boundsHeight < contentHeight else {
            return
        }
        
        let offset = contentOffset - (contentHeight - boundsHeight)
        
        if offset > 100 {
            guard let text = searchBar.text else { return }
            
            if !isLoading {
                isLoading = true
                searchWithOffset(text)
            }
        }
    }
}
