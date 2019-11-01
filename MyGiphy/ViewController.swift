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

class ViewController: UIViewController {
    let giphy = GiphyViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
         
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true )
        present(giphy, animated: true, completion: nil)
        giphyConfig()
    }
    
    func giphyConfig() {
        GiphyUISDK.configure(apiKey: "totF40WvhWTaFQzaNNl6n0okld9PPFHT")
        
        giphy.theme = .dark
        giphy.layout = .waterfall
        giphy.mediaTypeConfig = [.gifs, .stickers, .text, .emoji]
        giphy.showConfirmationScreen = true
        giphy.rating = .ratedPG13
        giphy.renditionType = .fixedWidth
        giphy.shouldLocalizeSearch = false
        GiphyViewController.trayHeightMultiplier = 0.7
        
    
        
    }
}

