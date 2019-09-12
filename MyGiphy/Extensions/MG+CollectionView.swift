//
//  MG+CollectionView.swift
//  MyGiphy
//
//  Created by Chris Chueh on 9/11/19.
//  Copyright © 2019 Tomorrow Ideas. All rights reserved.
//

import UIKit

extension UICollectionView {
    func calculateSizeForCollectionViewItem() -> CGSize {
        let cellsPerRow = 3
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let space = layout.sectionInset.left + layout.sectionInset.right + (layout.minimumInteritemSpacing * CGFloat(cellsPerRow - 1))
        
        let size = Int((self.bounds.width - space) / CGFloat(cellsPerRow))
        return CGSize(width: size, height: 100)
    }
}
