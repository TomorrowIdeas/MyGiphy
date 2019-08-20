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

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    var gifDataStore: GifDatastore
    let searchController = UISearchController(searchResultsController: nil)
    var searchWasCancelled = false
    
    init(layout: UICollectionViewLayout) {
        gifDataStore = GifDatastore.getInstance()
        super.init(collectionViewLayout: layout)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        GiphyCore.configure(apiKey: "SFTJDeB521aCKil7c97zdAACZAlm7yTq")
        
        navigationItem.title = "MyGiphy"
        
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(GiphyCell.self, forCellWithReuseIdentifier: "cellId")
        
        //setup search
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Gifs"
        searchController.searchBar.setValue("Search", forKey: "cancelButtonText")
        searchController.searchBar.text = "Tomorrow"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.isActive = true
        navigationItem.hidesSearchBarWhenScrolling = false
        
        searchGifs(searchPhrase: "Tomorrow")
        
    }
    
    //this cancel button is overrided to be Search
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchGifs(searchPhrase: searchController.searchBar.text!)
    }
    
    override func collectionView(_: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gifDataStore.getGifs().count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! GiphyCell
        cell.gif = gifDataStore.getGifs()[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailController = DetailViewController(gif: gifDataStore.getGifs()[indexPath.item])
        self.navigationController?.pushViewController(detailController, animated: true)
    }
    
    func searchGifs(searchPhrase: String) {
        var search = searchPhrase
        if(searchPhrase == "") {
            search = "Tomorrow"
        }
        
        GiphyCore.shared.search(searchPhrase, media: .gif, offset: 0, limit: 27, rating: .ratedPG, lang: .english) { (response, error) in
            if let medias = response?.data {
                DispatchQueue.main.sync { [weak self] in
                    
                    self?.gifDataStore.clearGifs()
                    for media in medias {
                        let downSampleUrl = media.images!.fixedHeightSmall!.gifUrl!
                        let originalUrl = media.images!.downsizedMedium!.gifUrl!
                        self?.gifDataStore.addGif(id: media.id, downSampleUrl: downSampleUrl, originalUrl: originalUrl)
                    }
                    self?.collectionView?.reloadData()
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 3
        return CGSize(width: width, height: 100)    //100 because the sample gifs always have a height of 100
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

