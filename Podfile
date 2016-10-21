source 'https://github.com/CocoaPods/Specs.git'
use_frameworks!

def import_pods
    pod 'DiscogsAPI', :path => '.'
end

target 'DiscogsAPI' do
    podspec
    pod 'RestKit/Testing', '~> 0.27.0'
    
    target 'DiscogsAPITests' do
        inherit! :search_paths
    end
    
    target 'Discogs-objc' do
		import_pods
    end
    
   target 'Discogs-swift' do
       import_pods
   end
   
end

