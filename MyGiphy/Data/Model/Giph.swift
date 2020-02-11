//
//  Giph.swift
//  MyGiphy
//
//  Created by Joey Nelson on 2/10/20.
//  Copyright © 2020 Tomorrow Ideas. All rights reserved.
//

import Foundation

struct Giph: Codable {
    var id: String
    var url: String
    var thumbnailURL: String
    var title: String
    
    enum CodingKeys: String, CodingKey {
        case id, title, images
    }
    
    enum ImagesCodingKeys: String, CodingKey {
        case original, downsized
    }
    
    enum OriginalCodingKeys: String, CodingKey {
        case url
    }
    
    enum DownsizedCodingKeys: String, CodingKey {
        case url
    }
    
    init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decode(String.self, forKey: .id)
            title = try container.decode(String.self, forKey: .title)
            
            let imagesInfo = try container.nestedContainer(keyedBy: ImagesCodingKeys.self, forKey: .images)
            
            let originalInfo = try imagesInfo.nestedContainer(keyedBy: OriginalCodingKeys.self, forKey: .original)
            url = try originalInfo.decode(String.self, forKey: .url)

            let downsizedInfo = try imagesInfo.nestedContainer(keyedBy: DownsizedCodingKeys.self, forKey: .downsized)
            thumbnailURL = try downsizedInfo.decode(String.self, forKey: .url)
        } catch {
            id = ""
            title = ""
            url = ""
            thumbnailURL = ""
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
    }
}
