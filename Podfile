source 'https://github.com/CocoaPods/Specs.git'

target "DiscogsAPI" do
	pod 'AFOAuth1Client', '~> 1.0.0'
    pod 'RestKit/ObjectMapping', '~> 0.26.0'
    pod 'RestKit/Network', '~> 0.26.0'
    
    target "Discogs-objc" do
        pod 'DiscogsAPI', :path => '.'
    end
end

