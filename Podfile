workspace 'Countries'

platform :ios, '11.0'
inhibit_all_warnings!
use_frameworks!

def install_pods
  # Reactive Extensions...
#  pod 'RxCocoa', '~> 5.1.0'

  # Dependency Injection...
#  pod 'Swinject', '~> 2.7.1'
#  pod 'SwinjectAutoregistration', '~> 2.7.0'

  # Utiltities...
#  pod 'R.swift', '~> 5.1.0'
  pod 'SwiftLint', '~> 0.39.1'
  pod 'CocoaLumberjack/Swift', '~> 3.6.1'   # Logger

  # Analytics / Crash Report...
#  pod 'Firebase/Analytics', '~> 6.19.0'
#  pod 'Fabric', '~> 1.10.2'
#  pod 'Crashlytics', '~> 3.14.0'
end

def install_test_pods
  pod 'Quick', '~> 2.2.0'
  pod 'Nimble', '~> 8.0.5'
#  pod 'Cuckoo', '~> 1.3.2'
#  pod 'RxBlocking'

  pod 'CocoaLumberjack/Swift', '~> 3.6.1'   # Logger
end

target 'Countries' do
  use_frameworks!
  install_pods
end

target 'CountriesTests' do
  install_test_pods
end

target 'Shared' do
  project 'Shared/Shared.xcodeporj'
  install_pods
end

target 'SharedTests' do
  project 'Shared/Shared.xcodeporj'
  install_test_pods
end
