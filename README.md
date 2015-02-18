# DiscogsAPI

An Objective-C interface for [Discogs API v2.0](http://www.discogs.com/developers/).

The implementation is based on the [RestKit](http://restkit.org/) framework.

###_DISCLAIMER_
** This library is still under construction.**

##Features
- Handle OAuth process and store the token in keychain.
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

### Setup
Import the header file

```objective-c
#import "DiscogsAPI.h"
```

In your Application delegate class, setup a DiscogsAPI static instance:
```objective-c

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	[...]
    
    DiscogsAPI* discogs = [DiscogsAPI discogsWithConsumerKey:@"Your consumer key" consumerSecret:@"Your consumer secret"];
    [DiscogsAPI setSharedClient:discogs];
    
    [...]
    return YES;
}
```
### Authenticate the user

OAuth process is all handled by the 'authentication' endpoint. You just have to show the 'authView' view to let the user enter his credentials and authorize the application. The token will be automatically stored in the Apple keychain.

```objective-c
	DiscogsAPI* discogs = [DiscogsAPI sharedClient];
    
    [discogs.authentication authenticateWithPreparedAuthorizationViewHandler:^(UIView *authView) {
        [authView setFrame:[[UIScreen mainScreen] bounds]];
        [self.view addSubview:authView];
        
    } success:^{
        NSLog(@"The user has been successfully authentified");
    } failure:^(NSError *error) {
    	NSLog(@"Error: %@", error);
    }];
```

### Search on Discogs database

```objective-c

	DGSearchRequest* request = [DGSearchRequest request];
    request.query = @"Cool band";
    request.type = @"artist";
    [request.pagination setPerPage:@25];
    
	DiscogsAPI* discogs = [DiscogsAPI sharedClient];
    
    [discogs.database searchFor:request success:^(DGSearchResponse *response) {
        [self.searchView setResponse:response];
    } failure:^(NSError *error) {
         NSLog(@"Error: %@", error);
    }];
```

## Documentation

##Author

- [Maxime Epain](https://github.com/maxep)

## License

DiscogsAPI is available under MIT License. See the [LICENSE](LICENSE) for more info.
