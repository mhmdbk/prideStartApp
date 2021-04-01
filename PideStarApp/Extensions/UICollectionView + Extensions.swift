//
//  UICollectionView + Extensions.swift
//  PideStarApp
//
//  Created by Mohammad Barek on 4/1/21.
//

import Foundation
import UIKit

extension UICollectionView {
    
public func register<T: UICollectionViewCell>(cellType: T.Type, bundle: Bundle? = nil) {
    let className = cellType.className
    let nib = UINib(nibName: className, bundle: bundle)
    register(nib, forCellWithReuseIdentifier: className)
}

public func register<T: UICollectionViewCell>(cellTypes: [T.Type], bundle: Bundle? = nil) {
    cellTypes.forEach { register(cellType: $0, bundle: bundle) }
}

public func register<T: UICollectionReusableView>(reusableViewType: T.Type,
                                                  ofKind kind: String = UICollectionView.elementKindSectionHeader,
                                                  bundle: Bundle? = nil) {
    let className = reusableViewType.className
    let nib = UINib(nibName: className, bundle: bundle)
    register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: className)
}

public func register<T: UICollectionReusableView>(reusableViewTypes: [T.Type],
                                                  ofKind kind: String = UICollectionView.elementKindSectionHeader,
                                                  bundle: Bundle? = nil) {
    reusableViewTypes.forEach { register(reusableViewType: $0, ofKind: kind, bundle: bundle) }
}

public func dequeueReusableCell<T: UICollectionViewCell>(with type: T.Type,
                                                         for indexPath: IndexPath) -> T {
    return dequeueReusableCell(withReuseIdentifier: type.className, for: indexPath) as! T
}
}
