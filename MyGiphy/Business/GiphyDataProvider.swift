//
//  GiphyDataProvider.swift
//  MyGiphy
//
//  Created by Joey Nelson on 2/10/20.
//  Copyright © 2020 Tomorrow Ideas. All rights reserved.
//

import Foundation

/// To be used for searching Giphy and paginating further results
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
    /// Performs the search with the current search parameters
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
    
    /// Begins new Giphy search
    public func search(withText text: String, completion: @escaping searchCompletion) {
        currentKeyword = text
        currentOffset = 0
        performSearch(completion)
    }
    
    /// Fetches the next page of giphs
    public func nextPage(completion: @escaping searchCompletion) {
        currentOffset += searchLimit
        performSearch(completion)
    }
}
