source 'https://github.com/CocoaPods/Specs.git'

project 'appnext-sample.xcodeproj'

workspace 'appnext-sample'

platform :ios, '8.0'
inhibit_all_warnings!

def common_pods
    pod 'Objection', :git => 'https://github.com/pivl/objection.git', :branch => 'watchos'
    pod 'libextobjc'
    pod 'MagicalRecord', :git => 'https://github.com/pivl/MagicalRecord.git', :branch => 'release/3.0'
    pod 'RegexKitLite'
    pod 'NSString+Color'
    pod 'AFNetworking', '~> 2.0'
end

def main_test_pods
    # pod 'RMStore', :git => 'https://github.com/tschmitz/RMStore.git', :branch => 'patch-1'
    # pod 'RMStore/AppReceiptVerifier', :git => 'https://github.com/tschmitz/RMStore.git', :branch => 'patch-1'
    # pod 'RMStore/TransactionReceiptVerifier', :git => 'https://github.com/tschmitz/RMStore.git', :branch => 'patch-1'
    # pod 'RMStore/NSUserDefaultsPersistence', :git => 'https://github.com/tschmitz/RMStore.git', :branch => 'patch-1'
    pod 'YYModel', '0.9.7'
    pod 'StateMachine', '0.1'
    pod 'UICKeyChainStore'
end

def main_app_pods
    main_test_pods

    pod 'SBJson', '< 4.0.0'
    pod 'GoogleAnalytics'
    pod 'BlocksKit', '2.2.5'
    pod 'MBProgressHUD', '~> 0.8'
    pod 'TKRoundedView', '0.4'
    pod 'Flurry-iOS-SDK'
    pod 'FBSDKCoreKit'
    pod 'OAStackView'
    pod 'MGSwipeTableCell'
    pod 'Flurry-iOS-SDK/FlurrySDK'
    pod 'JazzHands'
    pod 'Masonry'
    pod 'Doppelganger'
    pod 'MZFormSheetPresentationController'
    pod 'UIDevice-Hardware'
    pod 'HMSegmentedControl'
    pod 'ImageCenterButton', :git => 'https://github.com/crusnt/ImageCenterButton.git'
end

target 'appnext-sample' do
	common_pods
  main_app_pods
end

post_install do |installer|
    print "Set MR_ENABLE_ACTIVE_RECORD_LOGGING to 0\n"
    targets = installer.pods_project.targets.select {|t| t.to_s.end_with? "MagicalRecord"}
    targets.each do |target|
        target.build_configurations.each do |config|
            s = config.build_settings['GCC_PREPROCESSOR_DEFINITIONS']
            s ||= [ '$(inherited)' ]
            s.push('MR_ENABLE_ACTIVE_RECORD_LOGGING=0') if config.to_s == "Debug";
            config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] = s
        end
    end
end
