//
//  UICollectionViewCell+.swift
//  MyGiphy
//
//  Created by Joey Nelson on 2/10/20.
//  Copyright © 2020 Tomorrow Ideas. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func register(_ cellClass: Swift.AnyClass) {
        register(cellClass, forCellWithReuseIdentifier: String(describing: cellClass))
    }
    
    func dequeueReusableCell<Cell: UICollectionViewCell>(for indexPath: IndexPath) -> Cell {
        if let cell = dequeueReusableCell(withReuseIdentifier: String(describing: Cell.self), for: indexPath) as? Cell {
            return cell
        }
        else {
            fatalError("Inconsistent cell registration")
        }
    }
    
    func register(_ viewClass: Swift.AnyClass, forSupplementaryViewOfKind elementKind: String) {
        register(viewClass, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: String(describing: viewClass))
    }
    
    func dequeueReusableSupplementaryView<View: UICollectionReusableView>(ofKind elementKind: String, for indexPath: IndexPath) -> View {
        if let view = dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: String(describing: View.self), for: indexPath) as? View {
            return view
        }
        else {
            fatalError("Inconsistent view registration")
        }
    }
}
