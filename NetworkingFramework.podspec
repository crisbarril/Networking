
Pod::Spec.new do |s|

 s.name = "NetworkingFramework"
 s.version = "0.0.2"
 s.summary = "Networking Framework"
 s.description = "Framework to manage our networking tasks"
 s.homepage = "https://github.com/crisbarril/NetworkingFramework"
 s.license = { :type => 'MIT', :file => 'LICENSE' }
 s.platform = :ios, '11.0'
 s.author = { "Cristian Barril" => "crisbarril@hotmail.com" }
 s.swift_version = '4.0'
 
 s.source = { :git => "https://github.com/crisbarril/NetworkingFramework.git", :tag => s.version }

 s.default_subspecs = 'Full'

 s.subspec 'Full' do |ss|
  ss.dependency 'NetworkingFramework/Native'
  ss.dependency 'NetworkingFramework/Alamofire'
 end

 s.subspec 'Core' do |ss|
  ss.source_files  = "NetworkingFramework/Protocol/**/*.swift"
 end

 s.subspec 'Native' do |ss|
  ss.dependency 'NetworkingFramework/Core'
  ss.source_files  = "NetworkingFramework/NetworkClients/NativeClient.swift"
 end

 s.subspec 'Alamofire' do |ss|
  ss.dependency 'NetworkingFramework/Core'
  ss.dependency 'Alamofire', '4.7.2'
  ss.dependency 'SwiftyJSON', '4.1.0'
  ss.source_files  = "NetworkingFramework/NetworkClients/AlamofireClient.swift"
 end

end