Pod::Spec.new do |s|
  s.name         = "DiscogsAPI"
  s.version      = "1.0"
  s.summary      = "An Objective-C interface for Discogs API v2.0."
  s.description  = <<-DESC
                    An Objective-C interface for Discogs API v2.0.
                   DESC
  s.homepage     = "https://github.com/maxep/DiscogsAPI"
  s.license      = 'MIT'
  s.author       = { "Maxime Epain" => "maxime.epain@gmail.com" }
  s.source       = { :git => "https://github.com/maxep/DiscogsAPI.git" }
  s.requires_arc = true
  s.ios.deployment_target = '7.1'
  s.source_files = 'DiscogsAPI/**/*.{h,m}'
  s.dependency 'RestKit'
  s.dependency 'AFOAuth1Client'

  s.prefix_header_contents = <<-EOS
#import <Availability.h>

#ifndef __IPHONE_5_0
#warning "This project uses features only available in iOS SDK 5.0 and later."
#endif

#ifdef __OBJC__
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#endif

#if __IPHONE_OS_VERSION_MIN_REQUIRED
#import <SystemConfiguration/SystemConfiguration.h>
#import <MobileCoreServices/MobileCoreServices.h>
#else
#import <SystemConfiguration/SystemConfiguration.h>
#import <CoreServices/CoreServices.h>
#endif

// Make RestKit globally available
#import <RestKit/RestKit.h>
EOS

end
