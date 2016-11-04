#Change Log
All notable changes to `DiscogsAPI` project will be documented in this file.

--- 

## [1.6.0](https://github.com/maxep/DiscogsAPI/releases/tag/v1.6.0) - November 4, 2016

#### Added
- Listings and Orders to Marketplace endpoint.
- Unit tests.

#### Removed
- Carthage compatibility. RestKit is now a pod dependency using frameworks.
  As RestKit is not compatible with Carthage and to avoid duplicated symbols, Carthage can't be supported.

#### Updated
- Upgrade to RestKit 0.27.0
- `[DiscogsAPI client]` has been renamed to `[Discogs api]`.
- Swift 3 in example.

#### Fixed
- CocoaPods 1.1.1
- External browser authentication.

## [1.5.0](https://github.com/maxep/DiscogsAPI/releases/tag/v1.5.0) - July 1, 2016

#### Added
- Modular framework project.
- Swift compatibility.
- Carthage compatibility.
- Added format and field objects [#8](https://github.com/maxep/DiscogsAPI/pull/8).
- Added a get instance from folder method to collection [#8](https://github.com/maxep/DiscogsAPI/pull/8).

#### Fixed
- Fixed nil managers of wantlist and collections [#6](https://github.com/maxep/DiscogsAPI/pull/6).

## [1.4.2](https://github.com/maxep/DiscogsAPI/releases/tag/v1.4.2) - November 26, 2015

#### Updated
- Upgrade to RestKit 0.26.0

## [1.4.1](https://github.com/maxep/DiscogsAPI/releases/tag/v1.4.1) - October 6, 2015

#### Fixed
- Fix a major OAuth issue.

##~~[1.4](https://github.com/maxep/DiscogsAPI/releases/tag/v1.4)~~, August 28, 2015

#### Updated
- Upgrade to RestKit 0.25.0
