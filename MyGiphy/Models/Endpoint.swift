//
//  Endpoint.swift
//  MyGiphy
//
//  Created by Lahari on 06/11/2019.
//  Copyright © 2019 Tomorrow Ideas. All rights reserved.
//

import Foundation
import Keys

let keys = MyGiphyKeys()

struct Endpoint {
    let path: String
    let queryItems: [URLQueryItem]
}

extension Endpoint {
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.giphy.com"
        components.path = path
        components.queryItems = queryItems

        return components.url
    }
}

extension Endpoint {
    static func gifs(keword: String = "Lain", apiKey: String = keys.apiKey, limit: Int = 10) -> Endpoint {
        return Endpoint(
            path: "/v1/gifs/search",
            queryItems: [URLQueryItem(name: "q", value: keword),
                         URLQueryItem(name: "api_key", value: apiKey),
                         URLQueryItem(name: "limit", value: "\(limit)")]
        )
    }
}
