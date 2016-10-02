// DGLabelViewController.m
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

#import "DGLabelViewController.h"
#import <DiscogsAPI/DiscogsAPI.h>

@interface DGLabelViewController ()
@property (nonatomic, strong) DGLabelReleasesResponse *response;
@end

@implementation DGLabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // Get label details
    [Discogs.api .database getLabel:self.objectID success:^(DGLabel * _Nonnull label) {
        
        self.titleLabel.text    = label.name;
        self.detailLabel.text   = label.contactInfo;
        self.styleLabel.text    = label.profile;
        
        [Discogs.api.resource getImage:label.images.firstObject.resourceURL success:^(UIImage *image) {
            self.coverView.image = image;
        } failure:nil];
        
    } failure:^(NSError * _Nullable error) {
        NSLog(@"Error : %@", error);
    }];
    
    // Get label release
    DGLabelReleasesRequest *request = [DGLabelReleasesRequest request];
    request.labelID = self.objectID;
    request.pagination.perPage = @25;
    
    [Discogs.api.database getLabelReleases:request success:^(DGLabelReleasesResponse * _Nonnull response) {
        self.response = response;
    } failure:^(NSError * _Nullable error) {
        NSLog(@"Error : %@", error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setResponse:(DGLabelReleasesResponse *)response {
    _response = response;
    [self.tableView reloadData];
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.response.releases.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Releases";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReleaseCell"];
    
    DGLabelRelease *release = self.response.releases[indexPath.row];
    cell.textLabel.text       = release.title;
    cell.detailTextLabel.text = release.format;
    cell.imageView.image      = [UIImage imageNamed:@"default-release"];
    
    // Get a Discogs image
    [Discogs.api.resource getImage:release.thumb success:^(UIImage *image) {
        cell.imageView.image = image;
    } failure:nil];
    
    // Load the next response page
    if (release == self.response.releases.lastObject) {
        
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
        DGLabelRelease *release = self.response.releases[self.tableView.indexPathForSelectedRow.row];
        [(DGViewController *)segue.destinationViewController setObjectID:release.ID];
    }
}

@end
