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
        minimumInteritemSpacing = 10

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
