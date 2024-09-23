//
//  ExtentionCollectionCell.swift
//  ToDoListTestTask
//
//  Created by Александр Коротков on 18.09.2024.
//

import UIKit

extension UICollectionViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    var indexPath: IndexPath? {
        guard let collectionView = self.superview as? UICollectionView else {return nil}
        return collectionView.indexPath(for: self)
    }

}
