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
    
    
    var gifs = [Gif]()
    let searchController = UISearchController(searchResultsController: nil)
    var searchWasCancelled = false
    var searchText = ""
    
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
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        searchGifs(searchPhrase: "Tomorrow")
    }
    
    //this cancel button is overrided to be Search
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchGifs(searchPhrase: searchController.searchBar.text!)
    }
    
    //    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    //        searchWasCancelled = false
    //    }
    //
    //    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    //        searchWasCancelled = true
    //    }
    //
    //    private func searchBarTextDidEndEditing(searchBar: UISearchBar) {
    //        if searchWasCancelled {
    //            searchController.searchBar.text = self.searchText
    //        } else {
    //            self.searchText = searchController.searchBar.text!
    //        }
    //    }
    
    override func collectionView(_: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gifs.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! GiphyCell
        cell.gif = gifs[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print("tapped view \(gifs[indexPath.item].downSampleUrl)")
        let detailController = DetailViewController(gif: gifs[indexPath.item])
        self.navigationController?.pushViewController(detailController, animated: true)
    }
    
    func searchGifs(searchPhrase: String) {
        var search = searchPhrase
        if(searchPhrase == "") {
            search = "Tomorrow"
        }
        
        GiphyCore.shared.search(searchPhrase, media: .gif, offset: 0, limit: 24, rating: .ratedPG, lang: .english) { (response, error) in
            if let medias = response?.data {
                DispatchQueue.main.sync { [weak self] in
                    
                    self?.gifs = [Gif]()
                    for media in medias {
                        let downSampleUrl = media.images!.fixedHeightDownsampled!.gifUrl!
                        let originalUrl = media.images!.downsizedMedium!.gifUrl!
                        let newGif = Gif(id: media.id, downSampleUrl: downSampleUrl, originalUrl: originalUrl)
                        self?.gifs.append(newGif)
                    }
                    DispatchQueue.main.async {
                        self?.collectionView?.reloadData()
                    }
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 3
        return CGSize(width: width, height: 200)    //200 because the sample gifs always have a height of 200
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

