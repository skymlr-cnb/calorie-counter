# CalorieCounterSDK

A lightweight Swift Package that provides simple calorie counting features with data powered by Open Food Facts. Supports iOS 15+ and Swift 6.1.

## Integration

Add the package to your Xcode project using Swift Package Manager:

```
https://example.com/CalorieCounterSDK.git
```

Import the library in your code and optionally present the harness view in DEBUG builds:

```swift
import CalorieCounterSDK

#if DEBUG
CalorieCounterSDK.UITestHarnessView()
#endif
```

Run `swift build` and `swift test` to verify.
