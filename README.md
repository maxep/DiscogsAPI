# DiscogsAPI

[![CI Status](http://img.shields.io/travis/maxep/DiscogsAPI.svg?style=flat)](https://travis-ci.org/maxep/DiscogsAPI)
[![Version](https://img.shields.io/cocoapods/v/DiscogsAPI.svg?style=flat)](http://cocoadocs.org/docsets/DiscogsAPI)
[![License](https://img.shields.io/cocoapods/l/DiscogsAPI.svg?style=flat)](http://cocoadocs.org/docsets/DiscogsAPI)
[![Platform](https://img.shields.io/cocoapods/p/DiscogsAPI.svg?style=flat)](http://cocoadocs.org/docsets/DiscogsAPI)

An Objective-C interface for [Discogs API v2.0](http://www.discogs.com/developers/).

The implementation is based on the [RestKit](http://restkit.org/) framework.

##Features
- Supports OAuth process and store the token in keychain.
- Supports Discogs Auth.
- Database support: Release, Master Release, Master Release Versions, Artist, Artist Releases, Label, All Label Releases, Search.
- User support: Identify, Profile, Collection, Wantlist.
- Image support.

## Usage


### Installation with CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries in your projects.

##### Podfile

```ruby
platform :ios, '7.1'
pod 'DiscogsAPI'
```

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

The key/secret or your personal access token will be automatically retrieved from your xcode configuration and used in your request headers. Nothing to be done on your side.

##### OAuth

OAuth process is all handled by the 'authentication' endpoint. You just have to show the 'authView' view to let the user enter his credentials and authorize the application. The token will be automatically stored in the Apple keychain.

```objective-c
    [DiscogsAPI.client.authentication authenticateWithPreparedAuthorizationViewHandler:^(UIView *authView) {

        // Show the authView

    } success:^{
        NSLog(@"The user has been successfully authentified");
    } failure:^(NSError *error) {
        NSLog(@"Error: %@", error);
    }];
```

### Database

##### Release

```objective-c
    [DiscogsAPI.client.database getRelease:@249504 success:^(DGRelease *release) {
        NSLog(@"Release: %@", release);
    } failure:^(NSError *error) {
        NSLog(@"Error: %@", error);
    }];
```

##### Master Release

```objective-c
    [DiscogsAPI.client.database getMaster:@1000 success:^(DGMaster *master) {
        NSLog(@"Master: %@", master);
    } failure:^(NSError *error) {
        NSLog(@"Error: %@", error);
    }];
```
##### Master Release Versions

```objective-c
    DGMasterVersionRequest *request = [DGMasterVersionRequest request];
    request.masterID = @1000;
    request.pagination.page = @3;
    request.pagination.perPage = @25;

    [DiscogsAPI.client.database getMasterVersion:request success:^(DGMasterVersionResponse *response) {
        NSLog(@"Versions: %@", response.versions);
    } failure:^(NSError *error) {
        NSLog(@"Error: %@", error);
    }];
```

##### Search

```objective-c
    DGSearchRequest* request = [DGSearchRequest request];
    request.query = @"Cool band";
    request.type = @"artist";
    request.pagination.perPage = @25;

    [DiscogsAPI.client.database searchFor:request success:^(DGSearchResponse *response) {
        NSLog(@"Response: %@", response);
    } failure:^(NSError *error) {
        NSLog(@"Error: %@", error);
    }];
```

## Documentation

Documentation is available through [CocoaDocs](http://cocoadocs.org/docsets/DiscogsAPI)

## Author

[![GitHub](https://img.shields.io/badge/github-maxep-lightgrey.svg?style=flat)](https://github.com/maxep)
[![Twitter](https://img.shields.io/badge/twitter-%40MaximeEpain-blue.svg?style=flat)](https://twitter.com/MaximeEpain)
[![Email](https://img.shields.io/badge/email-maxime.epain%40gmail.com-red.svg?style=flat)](mailto:maxime.epain@gmail.com)

## License

DiscogsAPI is available under MIT License. See the [LICENSE](LICENSE) for more info.
