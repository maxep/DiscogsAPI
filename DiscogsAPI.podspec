Pod::Spec.new do |s|
  s.name         = "DiscogsAPI"
  s.version      = "1.1"
  s.summary      = "An Objective-C interface for Discogs API v2.0."
  s.description  = <<-DESC
                    Features:
					- Handle OAuth process and store tokens in keychain.
					- Database support: Release, Master Release, Master Release Versions, Artist, Artist Releases, Label, All Label Releases, Search.
					- User support: Identify, Profile, Collection, Wantlist.
					- Image support.
                   DESC
  s.homepage     = "https://github.com/maxep/DiscogsAPI"
  s.license      = 'MIT'
  s.author       = { "Maxime Epain" => "maxime.epain@gmail.com" }
  s.source       = { :git => "https://github.com/maxep/DiscogsAPI.git", :tag => "v#{s.version}" }
  s.requires_arc = true
  s.ios.deployment_target = '7.1'
  s.osx.deployment_target = '10.7'
  s.ios.frameworks 	= 'CFNetwork', 'MobileCoreServices', 'SystemConfiguration'
  s.osx.frameworks 	= 'CoreServices', 'SystemConfiguration'
  
  s.source_files = 'DiscogsAPI/*.{h,m}'
  s.default_subspecs = 'Authentication', 'Database', 'User', 'Resource'
  
  s.prefix_header_contents = <<-EOS
#if __has_include("RKCoreData.h")
    #import <CoreData/CoreData.h>
#endif
#import <Availability.h>

#define _AFNETWORKING_PIN_SSL_CERTIFICATES_

#if __IPHONE_OS_VERSION_MIN_REQUIRED
  #import <SystemConfiguration/SystemConfiguration.h>
  #import <MobileCoreServices/MobileCoreServices.h>
  #import <Security/Security.h>
#else
  #import <SystemConfiguration/SystemConfiguration.h>
  #import <CoreServices/CoreServices.h>
  #import <Security/Security.h>
#endif

// Make RestKit globally available
#import <RestKit/RestKit.h>
EOS

  s.subspec 'Authentication' do |ss|
    ss.source_files   = 'DiscogsAPI/Authentication'
    ss.dependency 'AFOAuth1Client', '~> 1.0.0'
  end
  
  s.subspec 'Database' do |ss|
    ss.source_files   = 	'DiscogsAPI/Database',
    						'DiscogsAPI/Database/Release', 
    						'DiscogsAPI/Database/Artist', 
    						'DiscogsAPI/Database/Label', 
    						'DiscogsAPI/Database/Master', 
    						'DiscogsAPI/Database/Search',
    						'DiscogsAPI/Database/Data'
    ss.dependency 'DiscogsAPI/Mapping'
  end
  
  s.subspec 'User' do |ss|
    ss.source_files   = 	'DiscogsAPI/User',
    						'DiscogsAPI/User/Identity', 
    						'DiscogsAPI/User/Profile', 
    						'DiscogsAPI/User/Collection', 
    						'DiscogsAPI/User/Wantlist'
    ss.dependency 'DiscogsAPI/Mapping'
  end
  
  s.subspec 'Resource' do |ss|
    ss.source_files   = 'DiscogsAPI/Resource'
    ss.dependency 'DiscogsAPI/Mapping'
  end
  
  s.subspec 'Mapping' do |ss|
    ss.source_files   = 'DiscogsAPI/Mapping/**/*.{h,m}'
    ss.dependency 'RestKit/ObjectMapping', '~> 0.25.0'
    ss.dependency 'RestKit/Network', '~> 0.25.0'
  end

end
