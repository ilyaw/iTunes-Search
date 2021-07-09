//
//  AppDetailScreenshotsViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Ilya on 05.07.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

class AppDetailScreenshotsViewController: UIViewController {
    
    private let app: ITunesApp
    
    private var appDetailWhatsNewView: AppDetailScreenshotsView {
        return self.view as! AppDetailScreenshotsView
    }
    
    init(app: ITunesApp) {
        self.app = app
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = AppDetailScreenshotsView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fillData()
    }
    
    private func fillData() {
        appDetailWhatsNewView.collectionView.delegate = self
        appDetailWhatsNewView.collectionView.dataSource = self
    }
}

extension AppDetailScreenshotsViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return app.screenshotUrls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = AppDetailConstants.getOptimalSize()

        return CGSize(width: size.width, height: size.height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScreenshotsCell.reuseId, for: indexPath) as? ScreenshotsCell else { return UICollectionViewCell() }
        
        cell.setup(with: app.screenshotUrls[indexPath.row])
        
        return cell
    }
    
    
}
