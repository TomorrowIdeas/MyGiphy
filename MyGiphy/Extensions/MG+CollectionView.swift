//
//  MG+CollectionView.swift
//  MyGiphy
//
//  Created by Chris Chueh on 9/11/19.
//  Copyright © 2019 Tomorrow Ideas. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    // Calculates the size of the cell based on number of cells in a row (2-4 looks best)
    func calculateSizeForCollectionViewItem(cellsPerRow: Int) -> CGSize {
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        
        // Minimum spacing for layout defaults to 10.0
        let space = layout.sectionInset.left + layout.sectionInset.right + (layout.minimumInteritemSpacing * CGFloat(cellsPerRow - 1))
        
        let size = Int((self.bounds.width - space) / CGFloat(cellsPerRow))
        
        // Fixed height of 100 based on fixed_height_small of the GPHMedia object
        return CGSize(width: size, height: 100)
    }
}
