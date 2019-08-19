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

class HomeController: UIViewController {
    
    
    var gifs = [Gif]()
    let searchController = UISearchController(searchResultsController: nil)
    var searchWasCancelled = false
    var searchText = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        GiphyCore.configure(apiKey: "SFTJDeB521aCKil7c97zdAACZAlm7yTq")
        
        navigationItem.title = "MyGiphy"
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        searchGifs(searchPhrase: "Tomorrow")
    }
    
    func searchGifs(searchPhrase: String) {
        var search = searchPhrase
        if(searchPhrase == "") {
            search = "Tomorrow"
        }
        
        GiphyCore.shared.search(searchPhrase, media: .gif, offset: 0, limit: 51, rating: .ratedPG, lang: .english) { (response, error) in
            if let medias = response?.data {
                DispatchQueue.main.sync { [weak self] in
                    
                    self?.gifs = [Gif]()
                    for media in medias {
                        let downSampleUrl = media.images!.fixedHeightDownsampled!.gifUrl!
                        let originalUrl = media.images!.downsizedMedium!.gifUrl!
                        let newGif = Gif(id: media.id, downSampleUrl: downSampleUrl, originalUrl: originalUrl)
                        self?.gifs.append(newGif)
                    }
                }
            }
        }
    }
}

