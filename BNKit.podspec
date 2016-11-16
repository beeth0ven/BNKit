Pod::Spec.new do |s|
    s.name = "BNKit"
    s.version = "0.0.1"
    s.license = { :type => "MIT", :file => "LICENSE" }
    s.summary = "BNKit"
    s.homepage = "https://github.com/beeth0ven/BNKit"
    s.author = { "Luo Jie" => "beeth0vendev@gmail.com" }
    s.source = { :git => "https://github.com/beeth0ven/BNKit.git", :tag => "#{s.version}"}

    s.platform = :ios
    s.ios.deployment_target = '9.0'
    s.requires_arc = true

    s.source_files = "BNKit/*.swift"
    s.resources = "BNKit/*.{storyboard,xib}"

    s.dependency 'RxSwift', '~> 3.0'
    s.dependency 'RxCocoa', '~> 3.0'
end

#   Pod Specification: https://guides.cocoapods.org/syntax/podspec.html
