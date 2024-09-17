//
//  FooterCollectionView.swift
//  ToDoListTestTask
//
//  Created by Александр Коротков on 17.09.2024.
//

import UIKit

final class FooterCollectionView: UICollectionView {
    
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        backgroundColor = .systemGray5
        translatesAutoresizingMaskIntoConstraints = false
        showsVerticalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
