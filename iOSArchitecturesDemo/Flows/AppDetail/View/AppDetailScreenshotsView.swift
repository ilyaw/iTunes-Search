//
//  AppDetailScreenshotsView.swift
//  iOSArchitecturesDemo
//
//  Created by Ilya on 05.07.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

class AppDetailScreenshotsView: UIView {
        
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 25.0)
        label.text = "Предпросмотр"
        return label
    }()
    
    private(set) var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
      
        collectionView.register(ScreenshotsCell.self, forCellWithReuseIdentifier: ScreenshotsCell.reuseId)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUI()
    }
    
    private func setUI() {
        self.addSubview(titleLabel)
        self.addSubview(collectionView)

        setConstraints()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)

//        backgroundColor = .blue
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12.0),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: AppDetailConstants.leftIndent),
            
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10.0),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor, constant: AppDetailConstants.leftIndent),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor, constant: AppDetailConstants.rightIndent),
            collectionView.heightAnchor.constraint(equalToConstant: AppDetailConstants.getOptimalSize().height)
        ])
    }
}
