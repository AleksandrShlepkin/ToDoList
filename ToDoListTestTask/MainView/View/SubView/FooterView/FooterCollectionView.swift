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
                 heightDimension: .estimated(180))
             let item = NSCollectionLayoutItem(layoutSize: itemSize)
             
             let groupHeight = NSCollectionLayoutDimension.estimated(180)
                          
             let groupSize = NSCollectionLayoutSize(
                 widthDimension: .fractionalWidth(1.0),
                 heightDimension: groupHeight )
             let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
             
             let section = NSCollectionLayoutSection(group: group)
             section.interGroupSpacing = 10

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


