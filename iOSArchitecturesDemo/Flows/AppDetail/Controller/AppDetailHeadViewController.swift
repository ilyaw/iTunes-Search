//
//  AppDetailHeadViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Ilya on 02.07.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

class AppDetailHeadViewController: UIViewController {
    
    private let app: ITunesApp
    private let imageLoader = ImageDownloader()
    
    private var appDetailHeadView: AppDetailHeaderView {
        return self.view as! AppDetailHeaderView
    }
    
    init(app: ITunesApp) {
        self.app = app
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = AppDetailHeaderView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillData()
    }
    
    private func fillData() {
        downloadImage()
        
        appDetailHeadView.titleLabel.text = app.appName
        appDetailHeadView.subtitleLabel.text = app.company
    }
    
    private func downloadImage() {
        guard let url = app.iconUrl else { return }
        
        imageLoader.getImage(fromUrl: url) { [weak self] (image, error) in
            guard let self = self else { return }
            
            if let error = error {
                //add alert
                print(error.localizedDescription)
                return
            }
            
            DispatchQueue.main.async {
                self.appDetailHeadView.imageView.image = image
            }
        }
    }

}
