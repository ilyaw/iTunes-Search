//
//  AppDetailViewController.swift
//  iOSArchitecturesDemo
//
//  Created by ekireev on 20.02.2018.
//  Copyright © 2018 ekireev. All rights reserved.
//

import UIKit

final class AppDetailViewController: UIViewController {
    
    public var app: ITunesApp
    
    private let presenter: AppDetailViewOutput
    
    lazy var headerViewController = AppDetailHeadViewController(app: app)
    lazy var infoViewController = AppDetailInfoViewController(app: app)
    lazy var whatsNewViewController = AppDetailWhatsNewViewController(app: app)
    lazy var screenshotsViewController = AppDetailScreenshotsViewController(app: app)
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private var appDetailView: AppDetailView {
        return self.view as! AppDetailView
    }
    
    init(app: ITunesApp) {
        self.app = app
        self.presenter = AppDetailPresenter()
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        self.view = AppDetailView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Private
    
    private func configureUI() {
        view.backgroundColor = .white
        
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        self.navigationItem.largeTitleDisplayMode = .never
        
        addScrollView()
        
        addChildHeaderViewController()
        addChildInfoViewController()
        addChildWhatsNewViewController()
        addChildScreenshotsViewController()
    }

    private func addScrollView() {
        self.appDetailView.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.appDetailView.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: self.appDetailView.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: self.appDetailView.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.appDetailView.bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: self.appDetailView.widthAnchor)
        ])

    }
    
    private func addChildHeaderViewController() {
        self.addChild(headerViewController)
        scrollView.addSubview(headerViewController.view)
        self.headerViewController.didMove(toParent: self)
        
        headerViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerViewController.view.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            headerViewController.view.leftAnchor.constraint(equalTo: self.appDetailView.safeAreaLayoutGuide.leftAnchor),
            headerViewController.view.rightAnchor.constraint(equalTo: self.appDetailView.safeAreaLayoutGuide.rightAnchor),
            headerViewController.view.heightAnchor.constraint(equalToConstant: AppDetailConstants.headerViewSize)
        ])
    }
    
    private func addChildInfoViewController() {
        self.addChild(infoViewController)
        scrollView.addSubview(infoViewController.view)
        self.infoViewController.didMove(toParent: self)
        
        infoViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            infoViewController.view.topAnchor.constraint(equalTo: self.headerViewController.view.bottomAnchor, constant: 10.0),
            infoViewController.view.leftAnchor.constraint(equalTo: self.appDetailView.safeAreaLayoutGuide.leftAnchor),
            infoViewController.view.rightAnchor.constraint(equalTo: self.appDetailView.safeAreaLayoutGuide.rightAnchor),
            infoViewController.view.heightAnchor.constraint(equalToConstant: AppDetailConstants.infoViewSize)
        ])
    }
    
    private func addChildWhatsNewViewController() {
        self.addChild(whatsNewViewController)
        scrollView.addSubview(whatsNewViewController.view)
        self.whatsNewViewController.didMove(toParent: self)
        
        whatsNewViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        let sizeText = presenter.getSizeText(text: app.releaseNotes ?? "")
       
        NSLayoutConstraint.activate([
            whatsNewViewController.view.topAnchor.constraint(equalTo: self.infoViewController.view.bottomAnchor, constant: 10.0),
            whatsNewViewController.view.leftAnchor.constraint(equalTo: self.appDetailView.safeAreaLayoutGuide.leftAnchor),
            whatsNewViewController.view.rightAnchor.constraint(equalTo: self.appDetailView.safeAreaLayoutGuide.rightAnchor),
            whatsNewViewController.view.heightAnchor.constraint(equalToConstant: AppDetailConstants.whatsNewViewSize + sizeText.height),
        ])
    }
    
    private func addChildScreenshotsViewController() {
        self.addChild(screenshotsViewController)
        scrollView.addSubview(screenshotsViewController.view)
        self.screenshotsViewController.didMove(toParent: self)
        
        screenshotsViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            screenshotsViewController.view.topAnchor.constraint(equalTo: self.whatsNewViewController.view.bottomAnchor, constant: 10.0),
            screenshotsViewController.view.leftAnchor.constraint(equalTo: self.appDetailView.safeAreaLayoutGuide.leftAnchor),
            screenshotsViewController.view.rightAnchor.constraint(equalTo: self.appDetailView.safeAreaLayoutGuide.rightAnchor),
            screenshotsViewController.view.heightAnchor.constraint(equalToConstant: 70 + AppDetailConstants.getOptimalSize().height),
            screenshotsViewController.view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    
    
//    private func qwe() {
//        self.addChild(qweView)
//        scrollView.addSubview(qweView.view)
//        self.qweView.didMove(toParent: self)
//
//        qweView.view.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            qweView.view.topAnchor.constraint(equalTo: self.whatsNewViewController.view.bottomAnchor, constant: 10.0),
//            qweView.view.leftAnchor.constraint(equalTo: self.appDetailView.safeAreaLayoutGuide.leftAnchor),
//            qweView.view.rightAnchor.constraint(equalTo: self.appDetailView.safeAreaLayoutGuide.rightAnchor),
//            qweView.view.heightAnchor.constraint(equalToConstant: 150),
//            qweView.view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
//        ])
//    }
    
    
    
//    private func configureNavigationController() {
//        self.navigationController?.navigationBar.tintColor = UIColor.white;
//        self.navigationItem.largeTitleDisplayMode = .never
//    }
//
//    private func downloadImage() {
//        guard let url = self.app?.iconUrl else { return }
//        self.appDetailView.throbber.startAnimating()
//        self.imageDownloader.getImage(fromUrl: url) { (image, error) in
//            self.appDetailView.throbber.stopAnimating()
//            guard let image = image else { return }
//            self.appDetailView.imageView.image = image
//        }
//    }
}

extension AppDetailViewController: AppDetailViewInput {    
    
}
