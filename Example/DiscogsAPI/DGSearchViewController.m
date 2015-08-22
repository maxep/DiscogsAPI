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

@implementation DGSearchViewCell
@end

@interface DGSearchViewController ()
@property (nonatomic, strong) DGSearchResponse *response;
@end

@implementation DGSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [DiscogsAPI.client isAuthenticated:^(BOOL success) {
        if (!success) {
            
            //Present Authentication controller
            DGAuthViewController *authentViewController = [[DGAuthViewController alloc] init];
            UINavigationController *authentNavigationController = [[UINavigationController alloc] initWithRootViewController:authentViewController];
            [self.navigationController presentViewController:authentNavigationController animated:YES completion:nil];
            
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Properties

- (void)setResponse:(DGSearchResponse *)response {
    _response = response;
    [self.tableView reloadData];
    [self.searchDisplayController.searchResultsTableView reloadData];
}

#pragma mark <UISearchDisplayDelegate>

- (void)searchDisplayController:(UISearchDisplayController *)controller didLoadSearchResultsTableView:(UITableView *)tableView {
    tableView.rowHeight = 66.f;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
   
    // Create a request with the search text
    DGSearchRequest *request = [DGSearchRequest request];
    request.query = searchString;
    request.pagination.perPage = @5;
    
    // Send the request and refresh the result table with the response
    [DiscogsAPI.client.database searchFor:request success:^(DGSearchResponse *response) {
        self.response = response;
    } failure:^(NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    return NO;
}

#pragma mark <UISearchBarDelegate>

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    // Create a request with the search text
    DGSearchRequest *request = [DGSearchRequest request];
    request.query = searchBar.text;
    request.pagination.perPage = @25;
    
    // Send the request and refresh the result table with the response
    [DiscogsAPI.client.database searchFor:request success:^(DGSearchResponse *response) {
        self.response = response;
    } failure:^(NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    [self.searchDisplayController setActive:NO animated:YES];
}

#pragma mark <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.response.results.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DGSearchViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"SearchCell"];
    
    // Set the cell with the related result
    if (indexPath.row < self.response.results.count) {
        DGSearchResult* result = [self.response.results objectAtIndex:indexPath.row];
        
        cell.title.text = result.title;
        cell.type.text = result.type;
        
        [DiscogsAPI.client.resource getImage:result.thumb success:^(UIImage *image) {
            cell.cover.image = image;
        } failure:^(NSError *error) {
            NSLog(@"Error: %@", error);
        }];
        
        if (tableView == self.tableView && result == [self.response.results lastObject]) {
            
            [self.response loadNextPageWithSuccess:^{
                [self.tableView reloadData];
            } failure:^(NSError *error) {
                NSLog(@"Error: %@", error);
            }];
        }
    }
    return cell;
}

@end
