//
//  AppDetailInfoViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Ilya on 04.07.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

class AppDetailInfoViewController: UIViewController {
    
    private let app: ITunesApp
//    private let imageLoader = ImageDownloader()
    
    private var appDetailInfoView: AppDetailInfoView {
        return self.view as! AppDetailInfoView
    }
    
    init(app: ITunesApp) {
        self.app = app
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = AppDetailInfoView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fillData()
    }
    
    private func fillData() {
       
        appDetailInfoView.ratingStarView.value = CGFloat(app.averageRating ?? 0)
        appDetailInfoView.ratingInfoLabel.text = String(format: "%.1f", app.averageRating ?? 0)
        
        if let byte = app.size {
            let sizeMB = byte / 1000000
            appDetailInfoView.sizeLabel.text = "\(sizeMB)"
        }
        
        appDetailInfoView.ageRestrictionsLabel.text = app.ageRestrictions
    

        
//        appDetailHeadView.titleLabel.text = app.appName
//        appDetailHeadView.subtitleLabel.text = app.company
        
//        appDetailHeadView.ratingLabel.text = String(describing: app.averageRating ?? 0)
    }

}

