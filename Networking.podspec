
Pod::Spec.new do |s|

 s.name = "Networking"
 s.version = "0.0.4"
 s.summary = "Networking Framework"
 s.description = "Framework to manage our networking tasks"
 s.homepage = "https://github.com/crisbarril/Networking"
 s.license = { :type => 'MIT', :file => 'LICENSE' }
 s.platform = :ios, '11.0'
 s.author = { "Cristian Barril" => "crisbarril@hotmail.com" }
 s.swift_version = '4.0'
 
 # Platforms
 s.ios.deployment_target = '10.0'
 s.watchos.deployment_target = '4.0'

 # Source 
 s.source = { :git => "https://github.com/crisbarril/Networking.git", :tag => s.version }

 s.default_subspecs = 'Full'

 s.subspec 'Full' do |ss|
  ss.dependency 'Networking/Native'
  ss.dependency 'Networking/Alamofire'
 end

 s.subspec 'Core' do |ss|
  ss.source_files  = "Networking/Protocol/**/*.swift"
 end

 s.subspec 'Native' do |ss|
  ss.dependency 'Networking/Core'
  ss.source_files  = "Networking/NetworkClients/NativeClient.swift"
 end

 s.subspec 'Alamofire' do |ss|
  ss.dependency 'Networking/Core'
  ss.dependency 'Alamofire', '4.7.2'
  ss.dependency 'SwiftyJSON', '4.1.0'
  ss.source_files  = "Networking/NetworkClients/AlamofireClient.swift"
 end

end
