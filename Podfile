source 'https://github.com/CocoaPods/Specs.git'
use_frameworks!

def import_pods
    pod 'DiscogsAPI', :path => '.'
end

target 'DiscogsAPI' do
    podspec
    
    target 'Discogs-objc' do
        inherit! :search_paths
        import_pods
    end
    
    target 'Discogs-swift' do
        inherit! :search_paths
        import_pods
    end
end

