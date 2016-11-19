source 'https://github.com/CocoaPods/Specs.git'
use_frameworks!

def import_pods
    pod 'DiscogsAPI', :path => '.'
end

target 'DiscogsAPI' do
    podspec
end

target 'DiscogsAPITests' do
    import_pods
    pod 'RestKit/Testing', '~> 0.27.0'
end

target 'Discogs-objc' do
    import_pods
end

target 'Discogs-swift' do
    import_pods
end

