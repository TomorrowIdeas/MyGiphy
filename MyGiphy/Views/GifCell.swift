//
//  GifCell.swift
//  MyGiphy
//
//  Created by Lahari on 06/11/2019.
//  Copyright © 2019 Tomorrow Ideas. All rights reserved.
//

import UIKit

class GifCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10
    }

    func configure(with gif: Datum) {
       
    }

}
