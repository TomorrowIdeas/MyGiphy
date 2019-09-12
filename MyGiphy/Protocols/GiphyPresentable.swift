//
//  GiphyPresentable.swift
//  MyGiphy
//
//  Created by Chris Chueh on 9/12/19.
//  Copyright © 2019 Tomorrow Ideas. All rights reserved.
//

import UIKit

protocol GiphyPresentable {
    var giphyURL: URL? { get }
    var qualityGiphyURL: URL? { get }
}
