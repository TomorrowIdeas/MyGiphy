//
//  GiphySearchResult.swift
//  MyGiphy
//
//  Created by Joey Nelson on 2/10/20.
//  Copyright © 2020 Tomorrow Ideas. All rights reserved.
//

import Foundation

struct GiphySearchResult: Codable {
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    let giphs: [Giph]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        giphs = try container.decode([Giph].self, forKey: .data)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(giphs, forKey: .data)
    }
}
