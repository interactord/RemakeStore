platform :ios, '12.2'

target 'RemakeStore' do

  use_frameworks!
  pod 'RxSwift', :inhibit_warnings => true
  pod 'RxCocoa', :inhibit_warnings => true
  pod 'Swinject', :inhibit_warnings => true 
  pod 'RxFlow', :inhibit_warnings => true
  pod 'TinyConstraints', :inhibit_warnings => true

  pod 'SCUIBuildKit'
  pod 'SCServiceKit'
  pod 'SCLayoutKit'

  target 'RemakeStoreTests' do
    inherit! :search_paths

    pod 'RxSwift', :inhibit_warnings => true
    pod 'RxCocoa', :inhibit_warnings => true
    pod 'RxBlocking', :inhibit_warnings => true
    pod 'RxTest', :inhibit_warnings => true

    pod 'RxFlow', :inhibit_warnings => true
    pod 'Swifter', :inhibit_warnings => true

    pod 'SCUIBuildKit'
    pod 'SCServiceKit'

  end

end
