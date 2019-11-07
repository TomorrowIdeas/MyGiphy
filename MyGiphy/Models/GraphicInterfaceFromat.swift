//
//  GraphicInterfaceFormat.swift
//  MyGiphy
//
//  Created by Lahari on 06/11/2019.
//  Copyright © 2019 Tomorrow Ideas. All rights reserved.
//

import Foundation

struct GraphicInterfaceFormat: Codable {
    let data: [Datum]
    let pagination: Pagination
    let meta: Meta
}

struct Datum: Codable {
    let type, id: String
    let url: String
    let slug: String
    let bitlyGIFURL, bitlyURL, embedURL: String
    let username: String
    let source: String
    let title, rating, contentURL, sourceTLD: String
    let sourcePostURL: String
    let isSticker: Int
    let importDatetime, trendingDatetime: String
    let images: Image
    let analytics: Analytics

    enum CodingKeys: String, CodingKey {
        case type, id, url, slug
        case bitlyGIFURL = "bitly_gif_url"
        case bitlyURL = "bitly_url"
        case embedURL = "embed_url"
        case username, source, title, rating
        case contentURL = "content_url"
        case sourceTLD = "source_tld"
        case sourcePostURL = "source_post_url"
        case isSticker = "is_sticker"
        case importDatetime = "import_datetime"
        case trendingDatetime = "trending_datetime"
        case images, analytics
    }
}

struct Analytics: Codable {
    let onload, onclick, onsent: Onclick
}

struct Onclick: Codable {
    let url: String
}

struct Image: Codable {
    let downsizedLarge, fixedHeightSmallStill: The480_WStill
    let original, fixedHeightDownsampled: FixedHeight
    let downsizedStill, fixedHeightStill, downsizedMedium, downsized: The480_WStill
    let previewWebp: The480_WStill
    let originalMp4: DownsizedSmall
    let fixedHeightSmall, fixedHeight: FixedHeight
    let downsizedSmall, preview: DownsizedSmall
    let fixedWidthDownsampled: FixedHeight
    let fixedWidthSmallStill: The480_WStill
    let fixedWidthSmall: FixedHeight
    let originalStill, fixedWidthStill: The480_WStill
    let looping: Looping
    let fixedWidth: FixedHeight
    let previewGIF, the480WStill: The480_WStill

    enum CodingKeys: String, CodingKey {
        case downsizedLarge = "downsized_large"
        case fixedHeightSmallStill = "fixed_height_small_still"
        case original
        case fixedHeightDownsampled = "fixed_height_downsampled"
        case downsizedStill = "downsized_still"
        case fixedHeightStill = "fixed_height_still"
        case downsizedMedium = "downsized_medium"
        case downsized
        case previewWebp = "preview_webp"
        case originalMp4 = "original_mp4"
        case fixedHeightSmall = "fixed_height_small"
        case fixedHeight = "fixed_height"
        case downsizedSmall = "downsized_small"
        case preview
        case fixedWidthDownsampled = "fixed_width_downsampled"
        case fixedWidthSmallStill = "fixed_width_small_still"
        case fixedWidthSmall = "fixed_width_small"
        case originalStill = "original_still"
        case fixedWidthStill = "fixed_width_still"
        case looping
        case fixedWidth = "fixed_width"
        case previewGIF = "preview_gif"
        case the480WStill = "480w_still"
    }
}

struct The480_WStill: Codable {
    let url: String
    let width, height: String
    let size: String?
}

struct DownsizedSmall: Codable {
    let height: String
    let mp4: String
    let mp4Size, width: String

    enum CodingKeys: String, CodingKey {
        case height, mp4
        case mp4Size = "mp4_size"
        case width
    }
}

struct FixedHeight: Codable {
    let height: String
    let mp4: String?
    let mp4Size: String?
    let size: String
    let url: String
    let webp: String
    let webpSize, width: String
    let frames, hash: String?

    enum CodingKeys: String, CodingKey {
        case height, mp4
        case mp4Size = "mp4_size"
        case size, url, webp
        case webpSize = "webp_size"
        case width, frames, hash
    }
}

struct Looping: Codable {
    let mp4: String
    let mp4Size: String

    enum CodingKeys: String, CodingKey {
        case mp4
        case mp4Size = "mp4_size"
    }
}

struct Meta: Codable {
    let status: Int
    let msg, responseID: String

    enum CodingKeys: String, CodingKey {
        case status, msg
        case responseID = "response_id"
    }
}

struct Pagination: Codable {
    let totalCount, count, offset: Int

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case count, offset
    }
}

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

extension URLSession {
    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? newJSONDecoder().decode(T.self, from: data), response, nil)
        }
    }

    func graphicInterfaceFormatTask(with url: URL, completionHandler: @escaping (GraphicInterfaceFormat?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}
