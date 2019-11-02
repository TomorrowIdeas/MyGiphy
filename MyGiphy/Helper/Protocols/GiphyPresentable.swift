//
//  GiphyPresentable.swift
//  MyGiphy
//
//  Created by Eugene Berezin on 11/1/19.
//  Copyright © 2019 Tomorrow Ideas. All rights reserved.
//

import Foundation
import UIKit

protocol GiphyPresentable {
    var giphyURL: URL? { get }
    var qualityGiphyURL: URL? { get }
}

