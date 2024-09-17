//
//  FooterCollectionViewFL.swift
//  ToDoListTestTask
//
//  Created by Александр Коротков on 17.09.2024.
//

import UIKit

final class FooterCollectionViewFL: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        scrollDirection = .vertical
        sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        itemSize = CGSize(width: 300, height: 150)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
