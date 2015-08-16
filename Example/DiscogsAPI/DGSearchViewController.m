//
//  ViewController.m
//  DiscogsAPI
//
//  Created by Maxime Epain on 16/08/2015.
//  Copyright (c) 2015 Maxime Epain. All rights reserved.
//

#import "DGSearchViewController.h"
#import "DGAuthViewController.h"
#import "DiscogsAPI.h"

@implementation DGSearchViewCell
@end

@interface DGSearchViewController ()
@property (nonatomic,readonly) DiscogsAPI *discogs;
@property (nonatomic, strong) DGSearchResponse *response;
@end

@implementation DGSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.discogs isAuthenticated:^(BOOL success) {
        if (!success) {
            [self presentAuthenticationController];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Properties

- (DiscogsAPI *)discogs {
    return [DiscogsAPI sharedClient];
}

- (void)setResponse:(DGSearchResponse *)response {
    _response = response;
    [self.tableView reloadData];
    [self.searchDisplayController.searchResultsTableView reloadData];
}

#pragma mark Private Methods

- (void)presentAuthenticationController {
    DGAuthViewController *authentViewController = [[DGAuthViewController alloc] init];
    UINavigationController *authentNavigationController = [[UINavigationController alloc] initWithRootViewController:authentViewController];
    [self.navigationController presentViewController:authentNavigationController animated:YES completion:nil];
}

#pragma mark <UISearchDisplayDelegate>

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
   
    // Create a request with the search text
    DGSearchRequest *request = [DGSearchRequest request];
    request.query = searchString;
    request.pagination.perPage = @5;
    
    // Send the request and refresh the result table with the response
    [self.discogs.database searchFor:request success:^(DGSearchResponse *response) {
        self.response = response;
    } failure:^(NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    return NO;
}

#pragma mark <UISearchBarDelegate>

- (void)searchDisplayController:(UISearchDisplayController *)controller didLoadSearchResultsTableView:(UITableView *)tableView {
    tableView.rowHeight = 66.f;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    // Create a request with the search text
    DGSearchRequest *request = [DGSearchRequest request];
    request.query = searchBar.text;
    request.pagination.perPage = @25;
    
    // Send the request and refresh the result table with the response
    [self.discogs.database searchFor:request success:^(DGSearchResponse *response) {
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
    
    if (cell == nil) {
        cell = [[DGSearchViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"SearchCell"];
    }
    
    // Set the cell with the related result
    if (indexPath.row < self.response.results.count) {
        DGSearchResult* result = [self.response.results objectAtIndex:indexPath.row];
        
        cell.title.text = result.title;
        cell.type.text = result.type;
        
        [[DiscogsAPI sharedClient].resource getImage:result.thumb success:^(UIImage *image) {
            cell.cover.image = image;
        } failure:^(NSError *error) {
            NSLog(@"Error: %@", error);
        }];
        
        if (tableView == self.tableView && result == [self.response.results lastObject]) {
            
            [self.response loadNextPageWithSuccess:^{
                [self.tableView reloadData];
            } failure:^(NSError *error) {}];
        }
    }
    return cell;
}

@end
