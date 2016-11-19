// DGMasterViewController.m
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

#import "DGMasterViewController.h"
#import <DiscogsAPI/DiscogsAPI.h>

@interface DGMasterViewController ()
@property (nonatomic, strong) DGMasterVersionsResponse *response;
@end

@implementation DGMasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Get master details
    [Discogs.api.database getMaster:self.objectID success:^(DGMaster * _Nonnull master) {
        
        self.titleLabel.text    = master.title;
        self.detailLabel.text   = master.artists.firstObject.name;
        self.yearLabel.text     = master.year.stringValue;
        self.styleLabel.text    = [master.genres componentsJoinedByString:@", "];
        
        [Discogs.api.resource getImage:master.thumb success:^(UIImage *image) {
            self.coverView.image = image;
        } failure:nil];
        
    } failure:^(NSError * _Nullable error) {
        NSLog(@"Error : %@", error);
    }];
    
    // Get master versions
    DGMasterVersionsRequest *request = [DGMasterVersionsRequest new];
    request.masterID = self.objectID;
    request.pagination.perPage = @25;
    
    [Discogs.api .database getMasterVersion:request success:^(DGMasterVersionsResponse * _Nonnull response) {
        self.response = response;
    } failure:^(NSError * _Nullable error) {
        NSLog(@"Error : %@", error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setResponse:(DGMasterVersionsResponse *)response {
    _response = response;
    [self.tableView reloadData];
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.response.versions.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Version";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReleaseCell"];
    
    DGMasterVersion *version = self.response.versions[indexPath.row];
    cell.textLabel.text       = version.title;
    cell.detailTextLabel.text = version.format;
    cell.imageView.image      = [UIImage imageNamed:@"default-release"];
    
    // Get a Discogs image
    [Discogs.api.resource getImage:version.thumb success:^(UIImage *image) {
        cell.imageView.image = image;
    } failure:nil];
    
    // Load the next response page
    if (version == self.response.versions.lastObject) {
        
        [self.response loadNextPageWithSuccess:^{
            [self.tableView reloadData];
        } failure:^(NSError * _Nullable error) {
            NSLog(@"Error : %@", error);
        }];
    }
    
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[DGViewController class]]) {
        DGMasterVersion *version = self.response.versions[self.tableView.indexPathForSelectedRow.row];
        [(DGViewController *)segue.destinationViewController setObjectID:version.ID];
    }
}

@end
