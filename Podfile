# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'UsabillaDashboard' do
  use_frameworks!
  pod 'ReactiveCocoa', '2.5'
  pod 'Firebase/Core'
  pod 'Firebase/Database'

  # Pods for UsabillaDashboard
  pod 'Masonry'
  pod 'ChameleonFramework'
  pod 'Charts'

  target 'UsabillaDashboardTests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end
