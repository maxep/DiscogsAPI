# DiscogsAPI

[![CI Status](http://img.shields.io/travis/maxep/DiscogsAPI.svg?style=flat)](https://travis-ci.org/maxep/DiscogsAPI)
[![Version](https://img.shields.io/cocoapods/v/DiscogsAPI.svg?style=flat)](http://cocoadocs.org/docsets/DiscogsAPI)
[![License](https://img.shields.io/cocoapods/l/DiscogsAPI.svg?style=flat)](http://cocoadocs.org/docsets/DiscogsAPI)
[![Platform](https://img.shields.io/cocoapods/p/DiscogsAPI.svg?style=flat)](http://cocoadocs.org/docsets/DiscogsAPI)

An Objective-C interface for [Discogs API v2.0](http://www.discogs.com/developers/).

The implementation is based on [RestKit v0.26.0](https://github.com/RestKit/RestKit).

##Features
- Supports OAuth process and store the token in keychain.
- Supports Discogs Auth.
- Database support: Release, Master Release, Master Release Versions, Artist, Artist Releases, Label, All Label Releases, Search.
- User support: Identify, Profile, Collection, Wantlist.
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

Detailed usage instructions are available in the [Wiki](https://github.com/maxep/DiscogsAPI/wiki).

## Version History

|       Version         |       Date            |       Description     |
|-----------------------|-----------------------|-----------------------|
|~~[1.4](https://github.com/maxep/DiscogsAPI/releases/tag/v1.4)~~|August 28, 2015  |See [wiki](https://github.com/maxep/DiscogsAPI/wiki) for API support. Upgrade to RestKit 0.25.0|
|[1.4.1](https://github.com/maxep/DiscogsAPI/releases/tag/v1.4.1)| October 6, 2015|Fix OAuth major issue.|
|[1.4.2](https://github.com/maxep/DiscogsAPI/releases/tag/v1.4.2)|November 26, 2015  |Upgrade to RestKit 0.26.0|
|[1.5.0](https://github.com/maxep/DiscogsAPI/releases/tag/v1.5.0)|July 1, 2016  |<ul><li>Build as modularized framework</li><li>Swift compatibility</li><li>Carthage compatibility</li></ul>|

## Documentation

Documentation is available through [CocoaDocs](http://cocoadocs.org/docsets/DiscogsAPI)

## Author

[Maxime Epain](http://maxep.github.io)

[![Twitter](https://img.shields.io/badge/twitter-%40MaximeEpain-blue.svg?style=flat)](https://twitter.com/MaximeEpain)

## License

DiscogsAPI is available under MIT License. See the [LICENSE](LICENSE) for more info.
