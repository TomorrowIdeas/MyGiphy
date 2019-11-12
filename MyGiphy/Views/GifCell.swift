//
//  GifCell.swift
//  MyGiphy
//
//  Created by Lahari on 06/11/2019.
//  Copyright © 2019 Tomorrow Ideas. All rights reserved.
//

import UIKit
import FLAnimatedImage

class GifCell: UICollectionViewCell {
    @IBOutlet weak var imageView: FLAnimatedImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10
        imageView.backgroundColor = .red
    }

    func configure(with gif: Datum) {
        guard let imageURL = URL(string: gif.images.downsized.url) else { return }
        do {
            let gifData = try Data(contentsOf: imageURL)
            imageView.animatedImage = FLAnimatedImage(gifData: gifData)
        } catch {
          print(error)
        }
    }
}
