//
//  SongCell.swift
//  iOSArchitecturesDemo
//
//  Created by Ilya on 08.07.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

class SongCell: UITableViewCell {
    
    static let reuseId = "SongCell"
    
    private(set) lazy var coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "noImage")
        imageView.layer.cornerRadius = (SongDetailConstants.smallArtworkSize.width / 2)
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16.0)
        return label
    }()
  
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }
    
    func configure(with model: SongCellModel) {
        titleLabel.text = model.songTitle
        
        if let urlPhoto = model.coverPhoto {
            downloadImage(urlPhoto)
        }
    }
    
    private func downloadImage(_ url: String) {
        if let image = ThreadSaveMemoryCache.shared.get(for: url) {
            self.coverImageView.image = image
            return
        }
        
        DispatchQueue.global().async {
            if let url = URL(string: url),
               let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.coverImageView.image = image
                    ThreadSaveMemoryCache.shared.set(for: url, image: image)
                }
            }
        }
    }
    
    private func setupCell() {
        self.contentView.addSubview(coverImageView)
        self.contentView.addSubview(titleLabel)
        
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            self.coverImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8.0),
            self.coverImageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 12.0),
            self.coverImageView.heightAnchor.constraint(equalToConstant: SongDetailConstants.smallArtworkSize.height),
            self.coverImageView.widthAnchor.constraint(equalToConstant: SongDetailConstants.smallArtworkSize.width),
            
            self.titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8.0),
            self.titleLabel.leftAnchor.constraint(equalTo: self.coverImageView.rightAnchor, constant: 8.0),
            self.titleLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -40.0),
            self.titleLabel.centerYAnchor.constraint(equalTo: coverImageView.centerYAnchor)
        ])
    }
    
    override func prepareForReuse() {
        titleLabel.text = nil
        coverImageView.image = nil
    }
    
}
