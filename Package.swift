// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "EasyTransitions",
    platforms: [.iOS(.v10), .tvOS(.v10)],
    products: [
        .library(name: "EasyTransitions", targets: ["EasyTransitions"]),
    ],
    targets: [
        .target(
            name: "EasyTransitions",
            path: "EasyTransitions/Classes"
        )
    ]
)
