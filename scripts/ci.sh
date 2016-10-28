#!/usr/bin/env bash

set -e

xcodebuild -workspace SwiftySQL.xcworkspace -scheme "SwiftySQL-iOS" -destination "platform=iOS Simulator,OS=9.3,name=iPhone 6s" test

xcodebuild -workspace SwiftySQL.xcworkspace -scheme "SwiftySQL-macOS" test

xcodebuild -workspace SwiftySQL.xcworkspace -scheme "SwiftySQL-tvOS" -destination "platform=tvOS Simulator,OS=9.0,name=Apple TV 1080p" test

