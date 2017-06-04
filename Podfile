platform :ios, '9.0'
use_frameworks!

def shared
    pod 'RxSwift',    '~> 3.0'
    pod 'RxCocoa',    '~> 3.0'
    pod 'RxDataSources', '~> 1.0'
    pod 'Action', '~> 3.0'
    pod 'RxFeedback', '~> 0.1'
end

target 'BNKit' do
    shared
end

target 'Example' do
    shared
end

target 'BNKitTests' do
    shared
    pod 'RxTest'
    pod 'RxBlocking'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.1.0'
            config.build_settings['MACOSX_DEPLOYMENT_TARGET'] = '10.10'
        end
    end
end

#   pod update --no-repo-update
#   The Podfile: http://guides.cocoapods.org/using/the-podfile.html
