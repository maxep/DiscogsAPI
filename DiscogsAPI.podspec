Pod::Spec.new do |s|
  s.name         = "DiscogsAPI"
  s.version      = "1.5.0"
  s.summary      = "An Objective-C interface for Discogs API v2.0."
  s.description  = <<-DESC
                    Features:
					- Supports OAuth process and store the token in keychain.
                    - Supports Discogs Auth.
					- Database support: Release, Master Release, Master Release Versions, Artist, Artist Releases, Label, All Label Releases, Search.
					- User support: Identify, Profile, Collection, Wantlist.
					- Image support.
                   DESC
  s.homepage     = "https://github.com/maxep/DiscogsAPI"
  s.license      = 'MIT'
  s.author       = { "Maxime Epain" => "maxime.epain@gmail.com" }
  s.social_media_url = 'https://twitter.com/MaximeEpain'
  s.source       = { :git => "https://github.com/maxep/DiscogsAPI.git", :tag => "v#{s.version}" }
  s.documentation_url = 'http://cocoadocs.org/docsets/DiscogsAPI'
  s.requires_arc = true
  s.ios.deployment_target = '7.1'
  s.ios.frameworks 	= 'CFNetwork', 'MobileCoreServices', 'SystemConfiguration'
  s.osx.frameworks 	= 'CoreServices', 'SystemConfiguration'
  
  s.source_files = 'DiscogsAPI/*.{h,m}'
  s.default_subspecs = 'Authentication', 'Database', 'User', 'Marketplace', 'Resource'

  s.subspec 'Core' do |ss|
    ss.source_files   = 	'DiscogsAPI/Core',
    						'DiscogsAPI/Configuration',
    						'AFOAuth1Client/AFOAuth1Client'
    ss.dependency 'RestKit/ObjectMapping', '~> 0.27.0'
    ss.dependency 'RestKit/Network', '~> 0.27.0'
    ss.prefix_header_contents = '#import <SystemConfiguration/SystemConfiguration.h>',
                                '#import <MobileCoreServices/MobileCoreServices.h>',
                                '#import <Security/Security.h>',
                                '#import <RestKit/RestKit.h>'
    ss.private_header_files = 'DiscogsAPI/Core/DGHTTPClient.h',
                              'DiscogsAPI/Mapping/Configuration/*.h',
                              'AFOAuth1Client/AFOAuth1Client/*.h'
  end
  
  s.subspec 'Authentication' do |ss|
    ss.source_files   = 	'DiscogsAPI/Authentication'
    ss.dependency 'DiscogsAPI/Core'
    ss.private_header_files = 'DiscogsAPI/Authentication/DGAuthView.h',
                              'DiscogsAPI/Authentication/DGTokenStore.h'
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
    ss.private_header_files = 'DiscogsAPI/Mapping/Database/**/*.h'
    ss.dependency 'DiscogsAPI/Pagination'
  end
  
  s.subspec 'User' do |ss|
    ss.source_files   = 	'DiscogsAPI/User',
    						'DiscogsAPI/User/Identity', 
    						'DiscogsAPI/User/Profile', 
    						'DiscogsAPI/User/Collection', 
    						'DiscogsAPI/User/Wantlist',
    						'DiscogsAPI/Mapping/User/**/*'
    ss.private_header_files = 'DiscogsAPI/Mapping/User/**/*.h'
    ss.dependency 'DiscogsAPI/Database'
  end
  
  s.subspec 'Marketplace' do |ss|
    ss.source_files   = 	'DiscogsAPI/Marketplace',
    						'DiscogsAPI/Marketplace/Price',
    						'DiscogsAPI/Mapping/Marketplace/**/*'
    ss.private_header_files = 'DiscogsAPI/Mapping/Marketplace/**/*.h'
    ss.dependency 'DiscogsAPI/Pagination'
  end
  
  s.subspec 'Pagination' do |ss|
    ss.source_files   = 	'DiscogsAPI/Pagination',
    						'DiscogsAPI/Mapping/Pagination'
    ss.private_header_files = 'DiscogsAPI/Mapping/Pagination/**/*.h'
    ss.dependency 'DiscogsAPI/Core'
  end
  
  s.subspec 'Resource' do |ss|
    ss.source_files   = 	'DiscogsAPI/Resource'
    ss.dependency 'DiscogsAPI/Core'
  end

end
