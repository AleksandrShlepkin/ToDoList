//
//  ViewController.swift
//  ToDoListTestTask
//
//  Created by Александр Коротков on 17.09.2024.
//

import UIKit

class MainViewController: UIViewController {
    
    var mainView: MainView?

    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainView
        mainView?.footerView.delegate = self
        mainView?.footerView.dataSource = self
    }
}

extension MainViewController: UICollectionViewDelegate {
    
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FooterCollectionCell", for: indexPath) as? FooterCollectionCell else { return UICollectionViewCell() }
        
        return cell
    }
    
    
}
