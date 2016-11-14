// DGSearchViewController.m
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

#import "DGSearchViewController.h"
#import "DGAuthViewController.h"
#import "DGViewController.h"
#import <DiscogsAPI/DiscogsAPI.h>

@interface DGSearchViewController () <UISearchResultsUpdating, UISearchBarDelegate>
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) DGSearchResponse *response;
@end

@implementation DGSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.definesPresentationContext = YES;
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    self.searchController.searchBar.scopeButtonTitles = @[@"All", @"Release", @"Master", @"Artist", @"Label"];
    self.searchController.searchBar.delegate = self;
    
    [Discogs.api isAuthenticated:^(BOOL success) {
        if (!success) {
            
            [self authenticate];
            
            //Present Authentication controller
//            DGAuthViewController *authentViewController = [[DGAuthViewController alloc] init];
//            UINavigationController *authentNavigationController = [[UINavigationController alloc] initWithRootViewController:authentViewController];
//            [self.navigationController presentViewController:authentNavigationController animated:YES completion:nil];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)authenticate {
    
    NSURL *callback = [NSURL URLWithString:@"discogs://success"];
    [Discogs.api.authentication authenticateWithCallback:callback success:^(DGIdentity *identity){
        
    } failure:^(NSError * _Nullable error) {
        NSLog(@"Error: %@", error);
    }];
}

#pragma mark Properties

- (void)setResponse:(DGSearchResponse *)response {
    _response = response;
    [self.tableView reloadData];
}

#pragma mark <UISearchResultsUpdating>

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *query = searchController.searchBar.text;
    NSString *type = @[@"", @"release", @"master", @"artist", @"label"][searchController.searchBar.selectedScopeButtonIndex];
    
    if (query.length > 0) {
        
        // Search on Discogs
        DGSearchRequest *request = [DGSearchRequest new];
        request.query = query;
        request.type = type;
        request.pagination.perPage = @25;
        
        [Discogs.api.database searchFor:request success:^(DGSearchResponse * _Nonnull response) {
            self.response = response;
        } failure:^(NSError * _Nullable error) {
            NSLog(@"Error: %@", error);
        }];
    }
}

#pragma mark <UISearchBarDelegate>

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope {
    [self updateSearchResultsForSearchController:self.searchController];
}

#pragma mark <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.response.results.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DGSearchResult *result = self.response.results[indexPath.row];
    UITableViewCell *cell = [self dequeueReusableCellWithResult:result];
    
    cell.textLabel.text       = result.title;
    cell.detailTextLabel.text = result.type;
    
    // Get a Discogs image
    [Discogs.api.resource getImage:result.thumb success:^(UIImage *image) {
        cell.imageView.image = image;
    } failure:nil];
    
    // Load the next response page
    if (result == self.response.results.lastObject) {
        
        [self.response loadNextPageWithSuccess:^{
            [self.tableView reloadData];
        } failure:^(NSError * _Nullable error) {
            NSLog(@"Error : %@", error);
        }];
    }
    
    return cell;
}

- (UITableViewCell *)dequeueReusableCellWithResult:(DGSearchResult *)result {
    UITableViewCell *cell = nil;
    
    if ([result.type isEqualToString:@"artist"]) {
        cell = [self.tableView dequeueReusableCellWithIdentifier:@"ArtistCell"];
        cell.imageView.image = [UIImage imageNamed:@"default-artist"];
    } else if ([result.type isEqualToString:@"label"]) {
        cell = [self.tableView dequeueReusableCellWithIdentifier:@"LabelCell"];
        cell.imageView.image = [UIImage imageNamed:@"default-label"];
    } else if ([result.type isEqualToString:@"master"]) {
        cell = [self.tableView dequeueReusableCellWithIdentifier:@"MasterCell"];
        cell.imageView.image = [UIImage imageNamed:@"default-release"];
    } else {
        cell = [self.tableView dequeueReusableCellWithIdentifier:@"ReleaseCell"];
        cell.imageView.image = [UIImage imageNamed:@"default-release"];
    }
    
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[DGViewController class]]) {
        DGSearchResult *result = self.response.results[self.tableView.indexPathForSelectedRow.row];
        [(DGViewController *)segue.destinationViewController setObjectID:result.ID];
    }
}

@end
