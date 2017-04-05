// DGSearchViewController.swift
//
// Copyright (c) 2017 Maxime Epain
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


import UIKit
import DiscogsAPI

class DGSearchViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate {
    
    var searchController : UISearchController!
    
    fileprivate var response: DGSearchResponse! {
        didSet { tableView.reloadData() }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController!.navigationBar.barStyle = UIBarStyle.black
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        searchController.searchBar.scopeButtonTitles = ["All", "Release", "Master", "Artist", "Label"]
        searchController.searchBar.delegate = self
        
        let callback = URL(string: "discogs-swift://success")
        Discogs.api.authentication.authenticate(withCallback: callback!, success: { (identity) in
            print("Authenticated user: \(identity)")
        }) { (error) in
            print(error)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let indexPath = tableView.indexPathForSelectedRow, let destination = segue.destination as? DGViewController {
            destination.objectID = response.results[indexPath.row].id
        }
    }

    // MARK: UISearchResultsUpdating
    
    func updateSearchResults(for searchController: UISearchController) {
        
        if let query = searchController.searchBar.text as String?, !query.isEmpty {
            
            let type = ["", "release", "master", "artist", "label"][searchController.searchBar.selectedScopeButtonIndex]
            
            // Search on Discogs 
            let request = DGSearchRequest()
            request.query = query
            request.type = type
            request.pagination.perPage = 25

            Discogs.api.database.search(for: request, success: { (response) in
                self.response = response
            }) { (error) in
                print(error)
            }
        }
    }
    
    // MARK: UISearchBarDelegate
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        updateSearchResults(for: searchController)
    }
    
    // MARK: UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return response?.results.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let result = response.results[indexPath.row]
        let cell = dequeueReusableCellWithResult(result)
        
        cell.textLabel?.text       = result.title
        cell.detailTextLabel?.text = result.type
        
        // Get a Discogs image
        if let thumb = result.thumb {
            Discogs.api.resource.getImage(thumb, success: { (image) in
                cell.imageView?.image = image
            })
        }
        
        // Load the next response page
        if result === response.results.last {
            response.loadNextPage(success: {
                self.tableView.reloadData()
            })
        }
        
        return cell
    }
    
    func dequeueReusableCellWithResult(_ result : DGSearchResult) -> UITableViewCell {
        guard let type = result.type else { return UITableViewCell() }
        
        let cell : UITableViewCell
        
        switch type {
        case "artist":
            cell = tableView.dequeueReusableCell(withIdentifier: "ArtistCell")!
            cell.imageView?.image = UIImage(named: "default-artist")
        case "label":
            cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell")!
            cell.imageView?.image = UIImage(named: "default-label")
        case "master":
            cell = tableView.dequeueReusableCell(withIdentifier: "MasterCell")!
            cell.imageView?.image = UIImage(named: "default-release")
        default:
            cell = tableView.dequeueReusableCell(withIdentifier: "ReleaseCell")!
            cell.imageView?.image = UIImage(named: "default-release")
        }
        
        return cell
    }
}
