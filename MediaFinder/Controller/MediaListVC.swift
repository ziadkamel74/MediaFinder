//
//  MoviesListVC.swift
//  RegistrationApp
//
//  Created by Ziad on 2/26/20.
//  Copyright © 2020 intake4. All rights reserved.
//

import UIKit
import AVKit

class MediaListVC: UIViewController {
    
    let databaseManager = DatabaseManager.shared()
    
    let tabBar = UITabBarController()
    @IBOutlet weak var tableView: UITableView!
    var receivedMediaArr: [ReceivedMedia] = []
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        setUpSearchController()
        loggedIn()
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        databaseManager.getLastSearchTextAndScope()
        getData(artistName: databaseManager.Text ?? "jack johnson", media: databaseManager.scope ?? 0)
        self.tableView.estimatedRowHeight = 183
        self.tableView.rowHeight = UITableView.automaticDimension
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        searchController.searchBar.sizeToFit()
        self.navigationItem.title = "Media"
        navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationItem.setHidesBackButton(true, animated: false)
        removeNavBarBorders()
    }
    
    private func setUpTableView() {
        tableView.register(UINib(nibName: Cells.mediaCell, bundle: nil), forCellReuseIdentifier: Cells.mediaCell)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setUpSearchController() {
        searchController.searchBar.scopeButtonTitles = ["All", "Music", "tvShow", "Movie"]
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Type something here to search"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.hidesNavigationBarDuringPresentation = true
    }
    
    private func setUpActivityIndicator() -> UIActivityIndicatorView {
        let ActivityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        ActivityIndicator.center = view.center
        ActivityIndicator.hidesWhenStopped = true
        return ActivityIndicator
    }
    
    
    private func getData(artistName: String, media: Int) {
        
        let myActivityIndicator = setUpActivityIndicator()
        myActivityIndicator.startAnimating()
        receivedMediaArr = []
        self.tableView.reloadData()
        view.addSubview(myActivityIndicator)
        APIManager.loadMovies(artistName: artistName, media: media) { (error, receivedMediaArr) in
            if let error = error {
                print(error.localizedDescription)
                myActivityIndicator.stopAnimating()
            } else if let receivedMediaArr = receivedMediaArr {
                self.receivedMediaArr = receivedMediaArr
                myActivityIndicator.stopAnimating()
                self.tableView.reloadData()
            }
        }
    }
    
    private func loggedIn() {
        UserDefaultsManager.shared().isLoggedIn = true
    }
    
    private func scrollToTop() {
        tableView.layoutIfNeeded()
        tableView.contentOffset = CGPoint(x: 0, y: -tableView.contentInset.top)
    }
    
}


extension MediaListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return receivedMediaArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cells.mediaCell, for: indexPath) as? MediaCell else {
            return UITableViewCell()
        }
        cell.configurecell(receivedMedia: receivedMediaArr[indexPath.row])
        cell.shadowAndBorderForCell(cell: cell)

        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        guard let previewUrl = receivedMediaArr[indexPath.row].previewUrl else { return  }
        guard let mediaUrl = URL(string: previewUrl) else { return }
        let player = AVPlayer(url: mediaUrl)
        let vc = AVPlayerViewController()
        vc.player = player
        self.showDetailViewController(vc, sender: self)
        vc.player?.play()
    }
}

extension MediaListVC: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        searchController.searchBar.selectedScopeButtonIndex = databaseManager.scope ?? 0
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchController.searchBar.text else { return }
        let selectedScope = searchController.searchBar.selectedScopeButtonIndex
        getData(artistName: text, media: selectedScope)
        databaseManager.updateMedia(text: text, scope: selectedScope)
        scrollToTop()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        databaseManager.getLastSearchTextAndScope()
    }
    
}

extension MediaListVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        let selectedScope = searchController.searchBar.selectedScopeButtonIndex
        databaseManager.scope = selectedScope
    }
    
}
