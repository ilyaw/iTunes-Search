//
//  ScreenshotsCell.swift
//  iOSArchitecturesDemo
//
//  Created by Ilya on 06.07.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

class ScreenshotsCell: UICollectionViewCell {
    
    static let reuseId = "ScreenshotsCell"
    
    private let screenshot: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        contentView.addSubview(screenshot)

        NSLayoutConstraint.activate([
            screenshot.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            screenshot.leftAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leftAnchor),
            screenshot.rightAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.rightAnchor),
            screenshot.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor)
        ])
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with url: String) {
        if let image = ThreadSaveMemoryCache.shared.get(for: url) {
            self.screenshot.image = image
            return
        }
        
        DispatchQueue.global().async {
            if let url = URL(string: url),
               let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.screenshot.image = image
                    ThreadSaveMemoryCache.shared.set(for: url, image: image)
                }
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.screenshot.image = nil
    }
    
}
