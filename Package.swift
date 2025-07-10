// swift-tools-version: 6.1
import PackageDescription

let package = Package(
    name: "CalorieCounterSDK",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(name: "CalorieCounterSDK", targets: ["Domain", "Data", "UITestHarness"])
    ],
    targets: [
        .target(name: "Domain"),
        .target(name: "Data", dependencies: ["Domain"]),
        .target(name: "UITestHarness", dependencies: ["Domain", "Data"]),
        .testTarget(name: "DomainTests", dependencies: ["Domain"]),
        .testTarget(
            name: "DataTests",
            dependencies: ["Data", "Domain"],
            resources: [.copy("Fixtures")]
        )
    ]
)
