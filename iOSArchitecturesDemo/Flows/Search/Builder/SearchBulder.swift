//
//  SearchBulder.swift
//  iOSArchitecturesDemo
//
//  Created by Ilya on 02.07.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

class SearchBulder {
    
    static func build() -> (UIViewController & SearchViewInput) {
        let presenter = SearchPresenter()
        let viewController = SearchViewController(presenter: presenter)
        presenter.viewInput = viewController
        
        return viewController
    }
}
