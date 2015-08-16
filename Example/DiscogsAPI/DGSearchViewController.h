//
//  ViewController.h
//  DiscogsAPI
//
//  Created by Maxime Epain on 16/08/2015.
//  Copyright (c) 2015 Maxime Epain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DGSearchViewCell: UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *cover;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *type;
@end

@interface DGSearchViewController : UITableViewController

@end

