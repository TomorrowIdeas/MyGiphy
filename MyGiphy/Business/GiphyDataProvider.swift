//
//  GiphyDataProvider.swift
//  MyGiphy
//
//  Created by Joey Nelson on 2/10/20.
//  Copyright © 2020 Tomorrow Ideas. All rights reserved.
//

import Foundation

class GiphyDataProvider {
    
    // MARK: Properties
    private var networkService: GiphyNetworkService
    
    // Search
    typealias searchCompletion = (_ giphs: [Giph], _ error: Error?) -> ()
    private var currentKeyword = ""
    private var currentOffset = 0
    private let searchLimit = 24
    
    init(networkService: GiphyNetworkService) {
        self.networkService = networkService
    }
    
    // MARK: Private methods
    private func performSearch(_ completion: @escaping searchCompletion) {
        networkService.searchGiphy(with: currentKeyword, limit: searchLimit, offset: currentOffset) { (giphs, error) in
            if let error = error {
                completion([], error)
            } else {
                completion(giphs, nil)
            }
        }
    }
    
    // MARK: Public methods
    public func search(withText text: String, completion: @escaping searchCompletion) {
        currentKeyword = text
        currentOffset = 0
        performSearch(completion)
    }
    
    public func nextPage(completion: @escaping searchCompletion) {
        currentOffset += searchLimit
        performSearch(completion)
    }
}
