#!/usr/bin/env bash

set -e

xcodebuild -project SwiftySQL.xcodeproj -scheme "SwiftySQLTests-iOS" -destination "platform=iOS Simulator,name=iPhone 6" test

xcodebuild -project SwiftySQL.xcodeproj -scheme "SwiftySQLTests-macOS" test

xcodebuild -project SwiftySQL.xcodeproj -scheme "SwiftySQLTests-tvOS" -destination "platform=tvOS Simulator,name=Apple TV 1080p" test

