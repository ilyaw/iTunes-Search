//
//  AppDetailInfoView.swift
//  iOSArchitecturesDemo
//
//  Created by Ilya on 04.07.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit
import HCSStarRatingView

class AppDetailInfoView: UIView {
    
    private(set) lazy var ratingInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = UIFont.boldSystemFont(ofSize: 25.0)
        return label
    }()
    
    private(set) lazy var ratingStarView: HCSStarRatingView = {
        let view = HCSStarRatingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.maximumValue = 5
        view.minimumValue = 0
        view.allowsHalfStars = true
        view.isUserInteractionEnabled = false
        return view
    }()
    
    private lazy var subRatingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Рейтинг"
        label.textColor = .lightGray
        label.font = UIFont.boldSystemFont(ofSize: 15.0)
        return label
    }()
    
    private(set) lazy var sizeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.text = "0"
        label.font = UIFont.boldSystemFont(ofSize: 25.0)
        return label
    }()
    
    private lazy var mbSizeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "МБ"
        label.textColor = .lightGray
        label.font = UIFont.boldSystemFont(ofSize: 15.0)
        return label
    }()
    
    private lazy var subsizeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Размер"
        label.textColor = .lightGray
        label.font = UIFont.boldSystemFont(ofSize: 15.0)
        return label
    }()
    
    private(set) lazy var ageRestrictionsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.text = "0+"
        label.font = UIFont.boldSystemFont(ofSize: 25.0)
        return label
    }()
    
    private lazy var subageRestrictionsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Возраст"
        label.textColor = .lightGray
        label.font = UIFont.boldSystemFont(ofSize: 15.0)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUI()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        backgroundColor = .white
    }
    
    private func setUI() {
        self.addSubview(ratingStarView)
        self.addSubview(ratingInfoLabel)
        self.addSubview(subRatingLabel)

        self.addSubview(sizeLabel)
        self.addSubview(mbSizeLabel)
        self.addSubview(subsizeLabel)
        
        self.addSubview(ageRestrictionsLabel)
        self.addSubview(subageRestrictionsLabel)
        
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            ratingInfoLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            ratingInfoLabel.topAnchor.constraint(equalTo: topAnchor),
            ratingInfoLabel.centerYAnchor.constraint(equalTo: ratingStarView.centerYAnchor),
            
            ratingStarView.topAnchor.constraint(equalTo: topAnchor),
            ratingStarView.leftAnchor.constraint(equalTo: ratingInfoLabel.rightAnchor, constant: 5),
            ratingStarView.heightAnchor.constraint(equalToConstant: 30),
            ratingStarView.widthAnchor.constraint(equalToConstant: 110),
            
            subRatingLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            subRatingLabel.topAnchor.constraint(equalTo: ratingInfoLabel.bottomAnchor, constant: 5),
           
            sizeLabel.topAnchor.constraint(equalTo: topAnchor),
            sizeLabel.rightAnchor.constraint(equalTo: mbSizeLabel.leftAnchor),
            
            mbSizeLabel.bottomAnchor.constraint(equalTo: subsizeLabel.topAnchor, constant: -8),
            mbSizeLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            
            subsizeLabel.topAnchor.constraint(equalTo: sizeLabel.bottomAnchor, constant: 5),
            subsizeLabel.centerXAnchor.constraint(equalTo: sizeLabel.centerXAnchor, constant: 5),
            
            ageRestrictionsLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 25),
            ageRestrictionsLabel.topAnchor.constraint(equalTo: topAnchor),
    
            subageRestrictionsLabel.topAnchor.constraint(equalTo: ageRestrictionsLabel.bottomAnchor, constant: 5),
            subageRestrictionsLabel.centerXAnchor.constraint(equalTo: ageRestrictionsLabel.centerXAnchor)
        
        ])
    
    }
    
}


