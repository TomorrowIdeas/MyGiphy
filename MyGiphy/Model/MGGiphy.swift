//
//  MGGiphy.swift
//  MyGiphy
//
//  Created by Chris Chueh on 9/10/19.
//  Copyright © 2019 Tomorrow Ideas. All rights reserved.
//

import Foundation
import GiphyCoreSDK

struct MGGiphy: Decodable {
    var user: GiphyUser?
//    var type: GiphyCoreSDK.GPHMediaType = .gif
//    var rating: GPHRatingType = .ratedPG
}

struct GiphyUser: Decodable {
    var username: String?
    var avatar_url: String?
}
