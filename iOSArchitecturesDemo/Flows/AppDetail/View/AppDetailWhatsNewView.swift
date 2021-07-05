//
//  AppDetailWhatsNewView.swift
//  iOSArchitecturesDemo
//
//  Created by Ilya on 05.07.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

class AppDetailWhatsNewView: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Что нового"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        return label
    }()
    
    private(set) lazy var versionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = UIFont.boldSystemFont(ofSize: 15.0)
        return label
    }()
    
    private(set) lazy var descriptionLabel: UITextView = {
        let textView = UITextView()
        textView.dataDetectorTypes = UIDataDetectorTypes.all
        textView.isScrollEnabled = false
        textView.isSelectable = true
        textView.isUserInteractionEnabled = true
        textView.isEditable = false
        textView.font = UIFont.systemFont(ofSize: 15.0)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private let versionHistoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Последнее обновление"
        label.textColor = .systemBlue
        label.font = UIFont.boldSystemFont(ofSize: 15.0)
        return label
    }()
    
    private(set) lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
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

//        backgroundColor = .brown
    }
    
    private func setUI() {
        self.addSubview(titleLabel)
        self.addSubview(versionLabel)
        self.addSubview(descriptionLabel)
        self.addSubview(versionHistoryLabel)
        self.addSubview(dateLabel)

        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            
            versionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            versionLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            
            descriptionLabel.topAnchor.constraint(equalTo: versionLabel.bottomAnchor, constant: 10),
            descriptionLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            descriptionLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
//            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            
            versionHistoryLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            versionHistoryLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            
            dateLabel.topAnchor.constraint(equalTo: versionHistoryLabel.bottomAnchor, constant: 10),
            dateLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            
            
        ])
    }
}
