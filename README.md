# DiscogsAPI

[![CI Status](http://img.shields.io/travis/maxep/DiscogsAPI.svg?style=flat)](https://travis-ci.org/maxep/DiscogsAPI)
[![Version](https://img.shields.io/cocoapods/v/DiscogsAPI.svg?style=flat)](http://cocoadocs.org/docsets/DiscogsAPI)
[![License](https://img.shields.io/cocoapods/l/DiscogsAPI.svg?style=flat)](http://cocoadocs.org/docsets/DiscogsAPI)
[![Platform](https://img.shields.io/cocoapods/p/DiscogsAPI.svg?style=flat)](http://cocoadocs.org/docsets/DiscogsAPI)

An Objective-C interface for [Discogs API v2.0](http://www.discogs.com/developers/).

The implementation is based on [RestKit v0.27.0](https://github.com/RestKit/RestKit).

## Features
- Supports OAuth process and store the token in keychain.
- Supports Discogs Auth.
- Database support: Release, Master Release, Master Release Versions, Artist, Artist Releases, Label, All Label Releases, Search.
- User support: Identify, Profile, Collection, Wantlist.
- Marketplace: Inventory, Listing.
- Image support.

## Installation with CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries in your projects.

##### Podfile

```ruby
pod 'DiscogsAPI'
```

## Usage

If you want to try it, simply run:

```
pod try DiscogsAPI
```
Or clone the repo and run ```pod install``` from the Example directory first.

### Authentication

Configure the .plist for your project:

Right-click your .plist file and choose "Open As Source Code".
Copy & Paste the XML snippet into the body of your file (`<dict>...</dict>`). You can use rather the key/secret pair or your personal access token (you can create them in your [profile settings](https://www.discogs.com/settings/developers)).

##### Key/Secret

Replace DISCOGS_APP_CONSUMER_KEY and DISCOGS_APP_CONSUMER_SECRET with your Discogs App consumer key and secret. 

```xml
<key>DiscogsConsumerKey</key>
<string>DISCOGS_APP_CONSUMER_Key</string>
<key>DiscogsConsumerSecret</key>
<string>DISCOGS_APP_CONSUMER_SECRET</string>
```

##### Personal Access Token

Replace DISCOGS_PERSONAL_ACCESS_TOKEN by you personal access token. 

```xml
<key>DiscogsAccessToken</key>
<string>DISCOGS_PERSONAL_ACCESS_TOKEN</string>
```
#### Authentication flow

Discogs supports two authentication methods: The Discogs Auth and OAuth. Please refer to the [documentation](http://www.discogs.com/developers/#page:authentication) for more details.

##### Discogs Auth

The key/secret or your personal access token will be automatically retrieved from your project configuration and used in your request headers. Nothing to be done on your side.

##### OAuth

OAuth process is all handled by the 'authentication' endpoint. You just have to show the 'authView' view to let the user enter his credentials and authorize the application. The token will be automatically stored in the keychains.

```objective-c
    [Discogs.api.authentication authenticateWithPreparedAuthorizationViewHandler:^(UIView *authView) {

        // Show the authView

    } success:^{
        NSLog(@"The user has been successfully authentified");
    } failure:^(NSError *error) {
        NSLog(@"Error: %@", error);
    }];
```

### Database

The following examples shows how to access Discogs database objects through the api.

##### Release

```objective-c
    [Discogs.api.database getRelease:@249504 success:^(DGRelease *release) {
        NSLog(@"Release: %@", release);
    } failure:^(NSError *error) {
        NSLog(@"Error: %@", error);
    }];
```

##### Master Release

```objective-c
    [Discogs.api.database getMaster:@1000 success:^(DGMaster *master) {
        NSLog(@"Master: %@", master);
    } failure:^(NSError *error) {
        NSLog(@"Error: %@", error);
    }];
```
##### Master Release Versions

```objective-c
    DGMasterVersionsRequest *request = [DGMasterVersionsRequest new];
    request.masterID = @1000;
    request.pagination.page = @3;
    request.pagination.perPage = @25;

    [Discogs.api.database getMasterVersion:request success:^(DGMasterVersionsResponse *response) {
        NSLog(@"Versions: %@", response.versions);
    } failure:^(NSError *error) {
        NSLog(@"Error: %@", error);
    }];
```
##### Artist

```objective-c
    [Discogs.api.database getArtist:@108713 success:^(DGArtist *artist) {
        NSLog(@"Artist: %@", artist);
    } failure:^(NSError *error) {
        NSLog(@"Error: %@", error);
    }];
```
##### Artist Releases

```objective-c
    DGArtistReleasesRequest *request = [DGArtistReleasesRequest new];
    request.artistID = @108713;
    request.pagination.page = @3;
    request.pagination.perPage = @25;
    
    [Discogs.api.database getArtistReleases:request success:^(DGArtistReleasesResponse *response) {
        NSLog(@"Releases: %@", response.releases);
    } failure:^(NSError *error) {
        NSLog(@"Error: %@", error);
    }];
```
##### Label

```objective-c
    [Discogs.api.database getLabel:@1 success:^(DGLabel *label) {
        NSLog(@"Label: %@", label);
    } failure:^(NSError *error) {
        NSLog(@"Error: %@", error);
    }];
```

##### Label Releases

```objective-c
    DGLabelReleasesRequest *request = [DGLabelReleasesRequest new];
    request.labelID = @1;
    request.pagination.page = @3;
    request.pagination.perPage = @25;
    
    [Discogs.api.database getLabelReleases:request success:^(DGLabelReleasesResponse *response) {
        NSLog(@"Releases: %@", response.releases);
    } failure:^(NSError *error) {
        NSLog(@"Error: %@", error);
    }];
```
##### Search

```objective-c
    DGSearchRequest *request = [DGSearchRequest new];
    request.query = @"Cool band";
    request.type = @"artist";
    request.pagination.perPage = @25;

    [Discogs.api.database searchFor:request success:^(DGSearchResponse *response) {
        NSLog(@"Results: %@", response.results);
    } failure:^(NSError *error) {
        NSLog(@"Error: %@", error);
    }];
```

### Pagination

From a paginated response, loading the next page is made easy by the `DGPaginated` protocol:

```objective-c
    [response loadNextPageWithSuccess:^{
        // Update UI
    } failure:^(NSError * _Nullable error) {
        NSLog(@"Error : %@", error);
    }];
```

### More usage

Detailed usage instructions are available in the [Wiki](https://github.com/maxep/DiscogsAPI/wiki).

## Documentation

Documentation is available through [CocoaDocs](http://cocoadocs.org/docsets/DiscogsAPI)

## Author

[Maxime Epain](http://maxep.github.io)

[![Twitter](https://img.shields.io/badge/twitter-%40MaximeEpain-blue.svg?style=flat)](https://twitter.com/MaximeEpain)

## License

DiscogsAPI is available under MIT License. See the [LICENSE](LICENSE) for more info.
