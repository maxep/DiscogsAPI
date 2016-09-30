source 'https://github.com/CocoaPods/Specs.git'

target "DiscogsAPI" do
    pod 'RestKit', '~> 0.27.0', :subspecs => ['Network', 'ObjectMapping']
    
    target "Discogs-objc" do
        pod 'DiscogsAPI', :path => '.'
    end
end

