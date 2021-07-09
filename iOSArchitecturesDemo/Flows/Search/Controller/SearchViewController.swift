//
//  ViewController.swift
//  iOSArchitecturesDemo
//
//  Created by ekireev on 14.02.2018.
//  Copyright © 2018 ekireev. All rights reserved.
//

import UIKit

final class SearchViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private var searchView: SearchView {
        return self.view as! SearchView
    }
    
    private let presenter: SearchViewOutput
    private let searchService = ITunesSearchService()
    
    private var lastQueryApp: String?
    private var lastQuerySong: String?
    
    private var searchMode: SearchMode = .apps
    
    var searchResultApps = [ITunesApp]() {
        didSet {
            updateTableView()
        }
    }
    
    var searchResultSongs = [ITunesSong]() {
        didSet {
            updateTableView()
        }
    }
    
    
    private func updateTableView() {
        searchView.tableView.isHidden = false
        searchView.tableView.reloadData()
        searchView.searchBar.resignFirstResponder()
    }
    
    init(presenter: SearchViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        self.view = SearchView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    private func setUI() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        self.searchView.searchBar.delegate = self
        self.searchView.delegate = self
        
        self.searchView.tableView.register(AppCell.self, forCellReuseIdentifier: AppCell.reuseId)
        self.searchView.tableView.register(SongCell.self, forCellReuseIdentifier: SongCell.reuseId)
        self.searchView.tableView.delegate = self
        self.searchView.tableView.dataSource = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.throbber(show: false)
    }
}

//MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch searchMode {
        case .apps:
            return searchResultApps.count
        case .songs:
            return searchResultSongs.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch searchMode {
        case .apps:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AppCell.reuseId, for: indexPath) as? AppCell else { return UITableViewCell() }
            
            let app = self.searchResultApps[indexPath.row]
            let cellModel = AppCellModelFactory.cellModel(from: app)
            cell.configure(with: cellModel)
            
            return cell
        case .songs:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SongCell.reuseId, for: indexPath) as? SongCell else { return UITableViewCell() }
            
            let song = self.searchResultSongs[indexPath.row]
            let cellModel = SongCellModelFactory.cellModel(from: song)
            cell.configure(with: cellModel)
            
            return cell
        }
    }
}

//MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch searchMode {
        case .apps:
            let app = searchResultApps[indexPath.row]
            presenter.viewDidSelectApp(app)
        case .songs:
            let song = searchResultSongs[indexPath.row]
            presenter.viewDidSelectSong(song)
        }
    }
}

//MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else {
            searchBar.resignFirstResponder()
            return
        }
        
        if query.count == 0 {
            searchBar.resignFirstResponder()
            return
        }
        
        switch searchMode {
        case .apps:
            lastQueryApp = self.searchView.searchBar.text
        case .songs:
            lastQuerySong = self.searchView.searchBar.text
        }
        
        presenter.viewDidSearch(with: query, searchMode: searchMode)
    }
}

extension SearchViewController: SearchViewInput {
    
    func throbber(show: Bool) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = show
    }
    
    func showError(error: Error) {
        let alert = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(actionOk)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showNoResults() {
        self.searchView.emptyResultView.isHidden = false
    }
    
    func hideNoResults() {
        self.searchView.emptyResultView.isHidden = true
    }
}

extension SearchViewController: SearchModeControlDelegate {
    func didSelectSearchMode(with mode: SearchMode) {
        searchMode = mode
        
        switch searchMode {
        case .apps:
            self.searchView.searchBar.text = lastQueryApp
        case .songs:
            self.searchView.searchBar.text = lastQuerySong
        }
        
        updateTableView()
    }
}
