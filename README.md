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

## Installation with CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries in your projects.

##### Podfile

```ruby
platform :ios, '7.1'
pod 'DiscogsAPI'
```

## Usage

If you want to try it, simply run:

```
pod try DiscogsAPI
```
Or clone the repo and run ```pod install``` from the Example directory first.

Detailed usage instructions are available in the [Wiki](https://github.com/maxep/DiscogsAPI/wiki).

## Documentation

Documentation is available through [CocoaDocs](http://cocoadocs.org/docsets/DiscogsAPI)

## Author

[![GitHub](https://img.shields.io/badge/github-maxep-lightgrey.svg?style=flat)](https://github.com/maxep)
[![Twitter](https://img.shields.io/badge/twitter-%40MaximeEpain-blue.svg?style=flat)](https://twitter.com/MaximeEpain)
[![Email](https://img.shields.io/badge/email-maxime.epain%40gmail.com-red.svg?style=flat)](mailto:maxime.epain@gmail.com)

## License

DiscogsAPI is available under MIT License. See the [LICENSE](LICENSE) for more info.
