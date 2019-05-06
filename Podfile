platform :ios, '12.2'

target 'RemakeStore' do

  use_frameworks!
  pod 'RxSwift', '~> 4.5', :inhibit_warnings => true
  pod 'RxCocoa', '~> 4.5', :inhibit_warnings => true
  pod 'SCServiceKit'
  pod 'Swinject', :inhibit_warnings => true 
  pod 'RxFlow', :inhibit_warnings => true

  target 'RemakeStoreTests' do
    inherit! :search_paths

    pod 'RxSwift', '~> 4.5', :inhibit_warnings => true
    pod 'RxCocoa', '~> 4.5', :inhibit_warnings => true
    pod 'RxBlocking', '~> 4.5', :inhibit_warnings => true
    pod 'RxTest', '~> 4.5', :inhibit_warnings => true

    pod 'RxFlow', :inhibit_warnings => true
    pod 'Swifter', :inhibit_warnings => true

    pod 'SCServiceKit'

  end

end

target 'SCLayoutKit' do
  # Uncomment the next line if you're using Swift or would like to use dynamic frameworks
  use_frameworks!

  # Pods for SCLayoutKit

  target 'SCLayoutKitTests' do
    inherit! :search_paths
    # Pods for testing
  end

end
