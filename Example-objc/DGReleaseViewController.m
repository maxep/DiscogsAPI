// DGReleaseViewController.m
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

#import "DGReleaseViewController.h"
#import <DiscogsAPI/DiscogsAPI.h>

@interface DGReleaseViewController ()
@property (nonatomic,strong) NSArray<DGTrack *> *trackList;
@end

@implementation DGReleaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [DiscogsAPI.client.database getRelease:self.objectID success:^(DGRelease * _Nonnull release) {
        self.titleLabel.text    = release.title;
        self.detailLabel.text   = release.artists.firstObject.name;
        self.yearLabel.text     = release.year.stringValue;
        self.styleLabel.text    = [release.genres componentsJoinedByString:@", "];
        self.trackList          = release.trackList;
        
        [DiscogsAPI.client.resource getImage:release.thumb success:^(UIImage *image) {
            self.coverView.image = image;
        } failure:nil];
        
    } failure:^(NSError * _Nullable error) {
        NSLog(@"Error : %@", error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setTrackList:(NSArray<DGTrack *> *)trackList {
    _trackList = trackList;
    [self.tableView reloadData];
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.trackList.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Tracks";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TrackCell"];
    
    DGTrack *track = self.trackList[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@.\t%@", track.position, track.title];
    cell.detailTextLabel.text = track.duration;
    
    return cell;
}

@end
