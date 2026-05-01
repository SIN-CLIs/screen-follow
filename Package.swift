// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "screen-follow",
    platforms: [.macOS(.v14)],
    products: [
        .executable(name: "screen-follow", targets: ["ScreenFollow"]),
    ],
    targets: [
        .executableTarget(
            name: "ScreenFollow",
            path: "Sources/ScreenFollow"
        ),
        .testTarget(
            name: "ScreenFollowTests",
            dependencies: ["ScreenFollow"],
            path: "Tests/ScreenFollowTests"
        ),
    ]
)
