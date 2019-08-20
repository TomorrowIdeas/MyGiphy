//
//  GifDatastore.swift
//  MyGiphy
//
//  Created by Noah Bragg on 8/19/19.
//  Copyright © 2019 Tomorrow Ideas. All rights reserved.
//

import Foundation

class GifDatastore {
    
    static var instance: GifDatastore? = nil
    private var gifs: [Gif]
    
    private init(){
        gifs = [Gif]()
    }
    
    static func getInstance() -> GifDatastore {
        if self.instance == nil {
            self.instance = GifDatastore()
        }
        return self.instance!
    }
    
    func getGifs() -> [Gif] {
        return self.gifs
    }
    
    func addGif(id: String, downSampleUrl: String, originalUrl: String) {
        let comments = UserDefaults.standard.array(forKey: id) as? [String] ?? [String]()
        
        let gif = Gif(id: id, downSampleUrl: downSampleUrl, originalUrl: originalUrl, comments: comments)
        self.gifs.append(gif)
    }
    
    func addComment(gifId: String, comment: String) {
        let gif = getGifForId(id: gifId)
        gif?.comments.insert(comment, at: 0)
        UserDefaults.standard.set(gif?.comments, forKey: gifId)
    }
    
    func getGifForId(id: String) -> Gif? {
        for gif in self.gifs {
            if(gif.id == id) {
                return gif
            }
        }
        return nil
    }
    
    func clearGifs() {
        gifs = [Gif]()
    }
}
