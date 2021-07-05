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
    
    lazy var headerViewController = AppDetailHeadViewController(app: app)
    lazy var infoViewController = AppDetailInfoViewController(app: app)
    
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
        
        addChildViewController()
        
        // MARK: Добавить дочерный вью контроллер
        addInfoController()
        
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
    
    private func addChildViewController() {
        self.addChild(headerViewController)
//        self.view.addSubview(headerViewController.view)
        scrollView.addSubview(headerViewController.view)
        self.headerViewController.didMove(toParent: self)
        
        headerViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerViewController.view.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            headerViewController.view.leftAnchor.constraint(equalTo: self.appDetailView.safeAreaLayoutGuide.leftAnchor),
            headerViewController.view.rightAnchor.constraint(equalTo: self.appDetailView.safeAreaLayoutGuide.rightAnchor),
            headerViewController.view.heightAnchor.constraint(equalToConstant: 140)
        ])
    }
    
    private func addInfoController() {
        self.addChild(infoViewController)
//        self.view.addSubview(infoViewController.view)

        scrollView.addSubview(infoViewController.view)
        self.infoViewController.didMove(toParent: self)
        
        infoViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            infoViewController.view.topAnchor.constraint(equalTo: self.headerViewController.view.bottomAnchor, constant: 10.0),
            infoViewController.view.leftAnchor.constraint(equalTo: self.appDetailView.safeAreaLayoutGuide.leftAnchor),
            infoViewController.view.rightAnchor.constraint(equalTo: self.appDetailView.safeAreaLayoutGuide.rightAnchor),
//            infoViewController.view.heightAnchor.constraint(equalToConstant: 500),
            infoViewController.view.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor)
//            infoViewController.view.bottomAnchor.constraint(equalTo: headerViewController.view.bottomAnchor, constant: 500.0)
        ])
        
//        self.addChild(headerViewController)
//        self.view.addSubview(headerViewController.view)
//        self.headerViewController.didMove(toParent: self)
//        
//        headerViewController.view.translatesAutoresizingMaskIntoConstraints = false
//        
//        NSLayoutConstraint.activate([
//            headerViewController.view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
//            headerViewController.view.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
//            headerViewController.view.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
//        ])
    }
    
    
    
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
