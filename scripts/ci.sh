#!/usr/bin/env bash

set -e

xcodebuild -workspace SwiftySQL.xcworkspace -scheme "SwiftySQL iOS" -destination "platform=iOS Simulator,name=iPhone 6" test

xcodebuild -workspace SwiftySQL.xcworkspace -scheme "SwiftySQL OSX" test

xcodebuild -workspace SwiftySQL.xcworkspace -scheme "SwiftySQL tvOS" -destination "platform=tvOS Simulator,name=Apple TV 1080p" test

