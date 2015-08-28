Pod::Spec.new do |s|
  s.name         = "DiscogsAPI"
  s.version      = "1.4"
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
  s.social_media_url = 'https://twitter.com/MaximeEpain'
  s.source       = { :git => "https://github.com/maxep/DiscogsAPI.git", :tag => "v#{s.version}" }
  s.requires_arc = true
  s.ios.deployment_target = '7.1'
  s.ios.frameworks 	= 'CFNetwork', 'MobileCoreServices', 'SystemConfiguration'
  s.osx.frameworks 	= 'CoreServices', 'SystemConfiguration'
  
  s.source_files = 'DiscogsAPI/*.{h,m}'
  s.default_subspecs = 'Authentication', 'Database', 'User', 'Resource'

  s.subspec 'Core' do |ss|
    ss.source_files   = 'DiscogsAPI/Core'
  end
  
  s.subspec 'Authentication' do |ss|
    ss.source_files   = 'DiscogsAPI/Authentication'
    ss.dependency 'DiscogsAPI/Core'
    ss.dependency 'AFOAuth1Client', '~> 1.0.0'
    ss.prefix_header_contents = '#import <SystemConfiguration/SystemConfiguration.h>',
    							'#import <MobileCoreServices/MobileCoreServices.h>'
  end
  
  s.subspec 'Database' do |ss|
    ss.source_files   = 	'DiscogsAPI/Database',
    						'DiscogsAPI/Database/Release', 
    						'DiscogsAPI/Database/Artist', 
    						'DiscogsAPI/Database/Label', 
    						'DiscogsAPI/Database/Master', 
    						'DiscogsAPI/Database/Search',
    						'DiscogsAPI/Database/Data',
    						'DiscogsAPI/Mapping/Database/**/*'
    ss.dependency 'DiscogsAPI/Pagination'
  end
  
  s.subspec 'User' do |ss|
    ss.source_files   = 	'DiscogsAPI/User',
    						'DiscogsAPI/User/Identity', 
    						'DiscogsAPI/User/Profile', 
    						'DiscogsAPI/User/Collection', 
    						'DiscogsAPI/User/Wantlist',
    						'DiscogsAPI/Mapping/User/**/*'
    ss.dependency 'DiscogsAPI/Database'
  end
  
  s.subspec 'Pagination' do |ss|
    ss.source_files   = 'DiscogsAPI/Pagination',
    					'DiscogsAPI/Mapping/Pagination'
    ss.dependency 'DiscogsAPI/Configuration'
  end
  
  s.subspec 'Resource' do |ss|
    ss.source_files   = 'DiscogsAPI/Resource'
    ss.dependency 'DiscogsAPI/Configuration'
  end
  
  s.subspec 'Configuration' do |ss|
    ss.source_files = 'DiscogsAPI/Configuration'
    ss.dependency 'DiscogsAPI/Core'
    ss.dependency 'RestKit/ObjectMapping', '~> 0.25.0'
    ss.dependency 'RestKit/Network', '~> 0.25.0'
    ss.prefix_header_contents = '#import <SystemConfiguration/SystemConfiguration.h>',
    							'#import <MobileCoreServices/MobileCoreServices.h>',
    							'#import <Security/Security.h>',
    							'#import <RestKit/RestKit.h>'
  end

end
