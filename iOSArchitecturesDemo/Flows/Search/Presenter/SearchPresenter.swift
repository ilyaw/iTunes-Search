//
//  SearchPresenter.swift
//  iOSArchitecturesDemo
//
//  Created by Ilya on 02.07.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

protocol SearchViewInput: AnyObject {
    var searchResultApps: [ITunesApp] { get set }
    var searchResultSongs: [ITunesSong] { get set }
    func showError(error: Error)
    func showNoResults()
    func hideNoResults()
    func throbber(show: Bool)
}

protocol SearchViewOutput: AnyObject {
    func viewDidSearch(with query: String, searchMode: SearchMode)
    func viewDidSelectApp(_ app: ITunesApp)
    func viewDidSelectSong(_ song: ITunesSong)
}

class SearchPresenter {
    private let searchService = ITunesSearchService()
    
    weak var viewInput: (UIViewController & SearchViewInput)?
    
    private func requestApps(with query: String) {
        self.searchService.getApps(forQuery: query) { [weak self] result in
            guard let self = self else { return }
            
            self.viewInput?.throbber(show: false)
            
            result.withValue { apps in
                guard !apps.isEmpty else {
                    self.viewInput?.searchResultApps = []
                    self.viewInput?.showNoResults()
                    return
                }
                self.viewInput?.hideNoResults()
                self.viewInput?.searchResultApps = apps
            }
            .withError {
                self.viewInput?.showError(error: $0)
            }
        }
    }
    
    private func requestSongs(with query: String) {
        self.searchService.getSongs(forQuery: query) { [weak self] result in
            guard let self = self else { return }
            
            self.viewInput?.throbber(show: false)
            
            result.withValue { songs in
                guard !songs.isEmpty else {
                    self.viewInput?.searchResultSongs = []
                    self.viewInput?.showNoResults()
                    return
                }
                self.viewInput?.hideNoResults()
                self.viewInput?.searchResultSongs = songs
            }
            .withError {
                self.viewInput?.showError(error: $0)
            }
        }
    }
    
    private func openAppDetails(with app: ITunesApp) {
        let appDetailViewController = AppDetailViewController(app: app)
        viewInput?.navigationController?.pushViewController(appDetailViewController, animated: true)
    }
    
    private func openSongDetail(with song: ITunesSong) {
//        let songDetailViewController = SongDetailViewController(song: song)
//        viewInput?.navigationController?.pushViewController(songDetailViewController, animated: true)
    }
}

extension SearchPresenter: SearchViewOutput {
    func viewDidSearch(with query: String, searchMode: SearchMode) {
        switch searchMode {
        case .apps:
            requestApps(with: query)
        case .songs:
            requestSongs(with: query)
        }
    }
    
    func viewDidSelectApp(_ app: ITunesApp) {
        openAppDetails(with: app)
    }
    
    func viewDidSelectSong(_ song: ITunesSong) {
        openSongDetail(with: song)
    }
}
