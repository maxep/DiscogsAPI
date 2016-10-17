// DGMasterViewController.swift
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

class DGMasterViewController: DGViewController {
    
    fileprivate var response : DGMasterVersionResponse! {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get master details
        Discogs.api().database .getMaster(self.objectID, success: { (master) in
            
            self.titleLabel.text    = master.title
            self.detailLabel.text   = master.artists.first?.name
            self.yearLabel.text     = master.year!.stringValue
            self.styleLabel.text    = master.genres.joined(separator: ", ")
            
            // Get a Discogs image
            if let image = master.images.first {
                Discogs.api().resource.getImage(image.resourceURL!, success: { (image) in
                    self.coverView?.image = image
                })
            }
            
        }) { (error) in
            print(error)
        }
        
        // Get master versions
        let request = DGMasterVersionRequest()
        request.masterID = self.objectID
        request.pagination.perPage = 25
        
        Discogs.api().database.getMasterVersion(request, success: { (response) in
            self.response = response
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
        
        if let indexPath = self.tableView.indexPathForSelectedRow {
            let result = self.response.versions[(indexPath as NSIndexPath).row]
            
            if let destination = segue.destination as? DGViewController {
                destination.objectID = result.id
            }
        }
    }
    
    // MARK: UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = self.response?.versions.count as Int? {
            return count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Versions"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "ReleaseCell")!
        let version = self.response.versions[indexPath.row]
        
        cell.textLabel?.text       = version.title
        cell.detailTextLabel?.text = version.format
        cell.imageView?.image      = UIImage(named: "default-release")
        
        // Get a Discogs image
        Discogs.api().resource.getImage(version.thumb!, success: { (image) in
            cell.imageView?.image = image
        })
        
        // Load the next response page
        if version === self.response.versions.last {
            self.response.loadNextPage(success: {
                self.tableView.reloadData()
            })
        }
        
        return cell
    }
}
