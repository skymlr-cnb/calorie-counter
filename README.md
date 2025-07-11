# CalorieCounterSDK

A lightweight Swift Package that provides simple calorie counting features. Food information can come from any language model conforming to `LLMClient` and by default uses a free HuggingFace endpoint. Supports iOS 15+ and Swift 6.1.

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

### Customising the LLM

`UITestHarnessView` uses `LLMFoodSearchRepository` with a `URLLLMClient` by default.
You can swap in any `LLMClient` implementation to experiment with different
models:

```swift
let client = URLLLMClient(url: URL(string: "https://api.example.com/model")!)
UITestHarnessView(service: LLMFoodSearchRepository(client: client))
```

Run `swift build` and `swift test` to verify.
