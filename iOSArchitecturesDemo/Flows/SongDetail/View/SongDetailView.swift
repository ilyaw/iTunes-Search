//
//  SongDetailView.swift
//  iOSArchitecturesDemo
//
//  Created by Ilya on 09.07.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

class SongDetailView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }
    
    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
        super.init(coder: coder)
        configureUI()
    }
    
    private func configureUI() {
        backgroundColor = .white
    }
}
