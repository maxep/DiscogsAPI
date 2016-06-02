// DGSearchViewController.swift
//
// Copyright (c) 2016 Maxime Epain
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

class DGSearchViewController: UITableViewController, UISearchResultsUpdating {
    
    var searchController : UISearchController!
    
    var response: DGSearchResponse! {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        DiscogsAPI.client().isAuthenticated { (success) in
            
            if !success {
                let authentViewController = DGAuthViewController()
                let authentNavigationController = UINavigationController.init(rootViewController: authentViewController)
                self.navigationController?.presentViewController(authentNavigationController, animated: true, completion: nil)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UISearchResultsUpdating
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        let request = DGSearchRequest()
        request.query = searchController.searchBar.text
        request.pagination.perPage = 5
        
        DiscogsAPI.client().database.searchFor(request, success: { (response) in
            self.response = response
            }) { (error) in
                NSLog("Error: %@", error)
        }
    }
    
    // MARK: UITableViewDataSource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = self.response?.results.count as Int? {
            return count
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("SearchCell")
        
        if indexPath.row < self.response.results.count {
            let result = self.response.results[indexPath.row] as! DGSearchResult
            
            cell?.textLabel?.text       = result.title
            cell?.detailTextLabel?.text = result.type
            
            DiscogsAPI.client().resource.getImage(result.thumb, success: { (image) in
                cell?.imageView?.image = image
                }, failure: { (error) in
                    NSLog("Error: %@", error)
            })
            
            if tableView === self.tableView && result === self.response.results.last {
                self.response.loadNextPageWithSuccess({ 
                    self.tableView.reloadData()
                    }, failure: { (error) in
                        NSLog("Error: %@", error)
                })
            }
        }
        
        return cell!
    }
}
