// DGSearchViewController.m
//
// Copyright (c) 2015 Maxime Epain
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

#import "DiscogsAPI.h"

NSString* const kCellIdentifier = @"ResultCell";

@interface DGSearchViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating>

@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) DGSearchResponse *response;

@end

@implementation DGSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"Search"];
    
    // Set up the result table
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    // Set up the serach controller (cf. https://developer.apple.com/library/ios/samplecode/TableSearch_UISearchController/Introduction/Intro.html )
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    [self.searchController.searchBar sizeToFit];
    self.searchController.delegate = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.searchBar.delegate = self;

    self.definesPresentationContext = YES;
    
    self.tableView.tableHeaderView = self.searchController.searchBar;
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
    
    DiscogsAPI* discogs = [DiscogsAPI sharedClient];
    
    [discogs isAuthenticated:^(BOOL success) {
        
        // Set the log button depending on the authentication status
        UIBarButtonItem *logButton = nil;
        
        if (success) {
            logButton = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(logout)];
        }
        else {
            logButton = [[UIBarButtonItem alloc] initWithTitle:@"login" style:UIBarButtonItemStylePlain target:self action:@selector(login)];
        }
        
        [self.navigationItem setRightBarButtonItem:logButton];
    }];
}

- (void) login {
    // Present the Authentication controller
    DGAuthViewController* authController = [[DGAuthViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:authController];
    
    [self presentViewController:navigationController animated:YES completion:nil];
}

- (void) logout {
    // Remove credential
    DiscogsAPI *discogs = [DiscogsAPI sharedClient];
    [discogs.authentication removeAccountCredential];
    
    // Change the log button
    UIBarButtonItem *logButton = [[UIBarButtonItem alloc] initWithTitle:@"login" style:UIBarButtonItemStylePlain target:self action:@selector(login)];
    [self.navigationItem setRightBarButtonItem:logButton];
}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    
    // Create a request with the search text
    DGSearchRequest *request = [DGSearchRequest request];
    request.query = searchBar.text;
    request.pagination.perPage = @25;
    
    DiscogsAPI* discogs = [DiscogsAPI sharedClient];
    
    // Send the request and refresh the result table with the response
    [discogs.database searchFor:request success:^(DGSearchResponse *response) {
        self.response = response;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

#pragma mark - UISearchResultsUpdating

- (void) updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    if (searchController.searchBar.text && ![searchController.searchBar.text isEqualToString:@""]) {

        DGSearchRequest *request = [DGSearchRequest request];
        request.query = searchController.searchBar.text;
        request.pagination.perPage = @5;
        
        DiscogsAPI* discogs = [DiscogsAPI sharedClient];
        
        [discogs.database searchFor:request success:^(DGSearchResponse *response) {
            self.response = response;
            [self.tableView reloadData];
        } failure:^(NSError *error) {
            NSLog(@"Error: %@", error);
        }];
    }
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //Number of result + the 'Load more' cell.
    return (self.response == nil)? 0 : self.response.results.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellIdentifier];
    }
    
    // Set the cell with the related result
    if (indexPath.row < self.response.results.count) {
        DGSearchResult* result = [self.response.results objectAtIndex:indexPath.row];
        
        [cell.textLabel setText:result.title];
        [cell.detailTextLabel setText:result.type];
    }
    // Set the 'Load more' cell
    else {
        [cell.textLabel setText:@"Load more ..."];
        NSInteger items = [self.response.pagination.items integerValue];
        NSInteger perPage = [self.response.pagination.perPage integerValue];
        NSInteger page = [self.response.pagination.page integerValue];
        NSInteger leftItems = items - (perPage * page);
        [cell.detailTextLabel setText:[NSString stringWithFormat:@"%ld %@", leftItems, @"items left"]];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row < self.response.results.count) {
        //Do something with the selected result...
    }
    else {
        [self.response loadNextPageWithSuccess:^{
            [self.tableView reloadData];
        } failure:^(NSError *error) {
            NSLog(@"Error: %@", error);
        }];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
