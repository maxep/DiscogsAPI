// DGLabelViewController.swift
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

class DGLabelViewController: DGViewController {
    
    private var response : DGLabelReleasesResponse!  {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get label details
        DiscogsAPI.client().database.getLabel(self.objectID, success: { (label) in
            
            self.titleLabel.text    = label.name
            self.detailLabel.text   = label.contactInfo
            self.styleLabel.text    = label.profile
            
            // Get a Discogs image
            if let image = label.images?.first {
                DiscogsAPI.client().resource.getImage(image.resourceURL!, success: { (image) in
                    self.coverView?.image = image
                    }, failure:nil)
            }
            
            }) { (error) in
                print(error)
        }

        // Get label release
        let request = DGLabelReleasesRequest()
        request.labelID = objectID
        request.pagination.perPage = 25
        
        DiscogsAPI.client().database.getLabelReleases(request, success: { (response) in
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let indexPath = self.tableView.indexPathForSelectedRow {
            let result = self.response.releases![indexPath.row]
            
            if let destination = segue.destinationViewController as? DGViewController {
                destination.objectID = result.ID
            }
        }
    }
    
    // MARK: UITableViewDataSource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = self.response?.releases!.count as Int? {
            return count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Releases"
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("ReleaseCell")!
        let result = self.response.releases![indexPath.row]
        
        cell.textLabel?.text       = result.title
        cell.detailTextLabel?.text = result.catno
        cell.imageView?.image      = UIImage.init(imageLiteral: "default-release")
        
        // Get a Discogs image
        DiscogsAPI.client().resource.getImage(result.thumb!, success: { (image) in
            cell.imageView?.image = image
            }, failure:nil)
        
        // Load the next response page
        if result === self.response.releases!.last {
            self.response.loadNextPageWithSuccess({
                self.tableView.reloadData()
                }, failure: { (error) in
                    print(error!)
            })
        }
        
        return cell
    }

}
