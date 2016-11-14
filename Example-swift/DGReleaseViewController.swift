// DGReleaseViewController.swift
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

class DGReleaseViewController: DGViewController {

    fileprivate var trackList : [DGTrack]! {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get release details
        Discogs.api.database.getRelease(self.objectID, success: { (release) in

            self.titleLabel.text    = release.title
            self.detailLabel.text   = release.artists.first?.name
            self.yearLabel.text     = release.year!.stringValue
            self.styleLabel.text    = release.genres.joined(separator: ", ")
            self.trackList          = release.trackList
            
            // Get a Discogs image
            if let image = release.images.first {
                Discogs.api.resource.getImage(image.resourceURL!, success: { (image) in
                    self.coverView?.image = image
                })
            }
            
        }) { (error) in
            print(error ?? "Error")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = self.trackList?.count as Int? {
            return count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Tracks"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrackCell")!
        
        let track = self.trackList[indexPath.row]
        cell.textLabel?.text = track.position! + ".\t" + track.title!
        cell.detailTextLabel?.text = track.duration
        
        return cell
    }
}
