//
//  DGViewController.swift
//  DiscogsAPI-Swift
//
//  Created by Maxime on 04/06/2016.
//  Copyright © 2016 Maxime Epain. All rights reserved.
//

import UIKit
import DiscogsAPI

class DGViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var coverView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var styleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    var objectID : NSNumber!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

}
