//
//  FooterCollectionViewFL.swift
//  ToDoListTestTask
//
//  Created by Александр Коротков on 17.09.2024.
//

import UIKit

final class FooterCollectionViewFL: UICollectionViewLayout {
    
    private var indexPathsToInsert: [IndexPath] = []
    private var indexPathsToDelete: [IndexPath] = []

    override func prepare(forCollectionViewUpdates updateItems: [UICollectionViewUpdateItem]) {
        super.prepare(forCollectionViewUpdates: updateItems)

    indexPathsToDelete = updateItems.filter { $0.updateAction == .delete }.compactMap { $0.indexPathBeforeUpdate }
    indexPathsToInsert = updateItems.filter { $0.updateAction == .insert }.compactMap { $0.indexPathAfterUpdate }
    }
    
    override func initialLayoutAttributesForAppearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attrs = super.initialLayoutAttributesForAppearingItem(at: itemIndexPath)
        
        guard indexPathsToInsert.contains(itemIndexPath) else {
            return attrs
        }
        
        // Rotate by 180 degrees
//        attrs?.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        
        // Center at the bottom of the collection view
        attrs?.center = CGPoint(x: collectionView!.bounds.midX, y: collectionView!.bounds.maxY)
        
        return attrs
    }
    
    override func finalLayoutAttributesForDisappearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attrs = super.finalLayoutAttributesForDisappearingItem(at: itemIndexPath)

        guard indexPathsToDelete.contains(itemIndexPath) else {
            return attrs
        }

        // Translate to the left by the width of the collection view
        attrs?.transform = CGAffineTransform(translationX: -collectionView!.bounds.width, y: 0)

        return attrs
    }
    
    override func finalizeCollectionViewUpdates() {
        super.finalizeCollectionViewUpdates()

        indexPathsToDelete = []
        indexPathsToInsert = []
    }
}
