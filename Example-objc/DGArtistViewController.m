// DGArtistViewController.m
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

#import "DGArtistViewController.h"
#import <DiscogsAPI/DiscogsAPI.h>

@interface DGArtistViewController ()
@property (nonatomic, strong) DGArtistReleaseResponse *response;
@end

@implementation DGArtistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Get artist details
    [DiscogsAPI.client.database getArtist:self.objectID success:^(DGArtist * _Nonnull artist) {
        
        self.titleLabel.text    = artist.name;
        self.styleLabel.text    = artist.profile;
        self.detailLabel.text   = [self membersAsString:artist.members];
        
        [DiscogsAPI.client.resource getImage:artist.images.firstObject.resourceURL success:^(UIImage *image) {
            self.coverView.image = image;
        } failure:nil];
        
    } failure:^(NSError * _Nullable error) {
        NSLog(@"Error : %@", error);
    }];
    
    // Get artist release
    DGArtistReleaseRequest *request = [DGArtistReleaseRequest request];
    request.artistID = self.objectID;
    request.pagination.perPage = @25;
    
    [DiscogsAPI.client.database getArtistReleases:request success:^(DGArtistReleaseResponse * _Nonnull response) {
        self.response = response;
    } failure:^(NSError * _Nullable error) {
        NSLog(@"Error : %@", error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setResponse:(DGArtistReleaseResponse *)response {
    _response = response;
    [self.tableView reloadData];
}

- (NSString *)membersAsString:(NSArray<DGMember *> *)members {
    NSMutableArray *names = [NSMutableArray array];
    for (DGMember *member in members) {
        [names addObject:member.name];
    }
    return [names componentsJoinedByString:@", "];
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.response.releases.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Releases";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DGArtistRelease *release = self.response.releases[indexPath.row];
    UITableViewCell *cell = [self dequeueReusableCellWithResult:release];
    
    cell.textLabel.text       = release.title;
    cell.detailTextLabel.text = release.format;
    cell.imageView.image      = [UIImage imageNamed:@"default-release"];
    
    // Get a Discogs image
    [DiscogsAPI.client.resource getImage:release.thumb success:^(UIImage *image) {
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

- (UITableViewCell *)dequeueReusableCellWithResult:(DGArtistRelease *)release {
    
    if ([release.type isEqualToString:@"master"]) {
        return [self.tableView dequeueReusableCellWithIdentifier:@"MasterCell"];
    }
    return [self.tableView dequeueReusableCellWithIdentifier:@"ReleaseCell"];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[DGViewController class]]) {
        DGArtistRelease *release = self.response.releases[self.tableView.indexPathForSelectedRow.row];
        [(DGViewController *)segue.destinationViewController setObjectID:release.ID];
    }
}

@end
