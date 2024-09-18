//
//  FooterCollectionView.swift
//  ToDoListTestTask
//
//  Created by Александр Коротков on 17.09.2024.
//

import UIKit

final class FooterCollectionView: UICollectionView {
    
    private func createLayout() -> UICollectionViewLayout {
         let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in

             let itemSize = NSCollectionLayoutSize(
                 widthDimension: .fractionalWidth(1.0),
                 heightDimension: .fractionalHeight(1.0))
             let item = NSCollectionLayoutItem(layoutSize: itemSize)
             item.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
                          
             let groupSize = NSCollectionLayoutSize(
                 widthDimension: .fractionalWidth(1.0),
                 heightDimension: .fractionalHeight(0.2) )
             let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
             
             let section = NSCollectionLayoutSection(group: group)

             return section
         }
         return layout
     }
     
     private func configureHierarchy() {
         self.collectionViewLayout = createLayout()
         self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
         self.backgroundColor = .systemGray5
         self.register(FooterCollectionCell.self, forCellWithReuseIdentifier: FooterCollectionCell.identifier)
         
     }
    
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        translatesAutoresizingMaskIntoConstraints = false
        showsVerticalScrollIndicator = false
        configureHierarchy() 
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
