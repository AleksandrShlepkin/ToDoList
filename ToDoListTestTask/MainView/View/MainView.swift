//
//  MainView.swift
//  ToDoListTestTask
//
//  Created by Александр Коротков on 17.09.2024.
//

import UIKit

final class MainView: UIView {
        
    private(set) lazy var footerView: FooterCollectionView = {
        let layout = FooterCollectionViewFL()
        let collection = FooterCollectionView(frame: .zero, collectionViewLayout: layout)
        
        return collection
    }()

    private lazy var headerView = HeaderView()
    private lazy var middleView = MiddleView()
    
    private var mokView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


private extension MainView {
    
    func setupView() {
        backgroundColor = .systemGray5
        addSubview(headerView)
        addSubview(middleView)
        addSubview(footerView)
        footerView.register(FooterCollectionCell.self, forCellWithReuseIdentifier: FooterCollectionCell.identifier)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 150),
            
            middleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            middleView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 10),
            middleView.trailingAnchor.constraint(greaterThanOrEqualTo: trailingAnchor, constant: -100),
            
            footerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            footerView.topAnchor.constraint(equalTo: middleView.bottomAnchor),
            footerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            footerView.bottomAnchor.constraint(equalTo: bottomAnchor)
            
        ])
    }
}
