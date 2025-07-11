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
If your chosen model requires an API token, pass any extra HTTP headers to the client:

```swift
let headers = ["Authorization": "Bearer YOUR_TOKEN"]
let client = URLLLMClient(url: URL(string: "https://api.example.com/model")!,
                          headers: headers)
UITestHarnessView(service: LLMFoodSearchRepository(client: client))
```

`URLLLMClient` will also read a HuggingFace token from the `HF_API_TOKEN` environment
variable if no `Authorization` header is supplied. Set this variable to avoid 401
errors with the default endpoint.

Non-2xx responses are printed to the console with their HTTP status code and body to aid debugging.

Run `swift build` and `swift test` to verify.
