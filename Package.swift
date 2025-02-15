// swift-tools-version:6.0

import PackageDescription

let package:Package = .init(name: "swift-webref",
    platforms: [.macOS(.v10_13)],
    products: [
        // .executable(name: "WebAPIKitDemo", targets: ["WebAPIKitDemo"]),

        // .library(name: "WebAPIBase", targets: ["WebAPIBase"]),
        // .library(name: "DOM", targets: ["DOM"]),
        // .library(name: "WebSockets", targets: ["WebSockets"]),
        // .library(name: "WebAudio", targets: ["WebAudio"]),
        // .library(name: "WebAnimations", targets: ["WebAnimations"]),
        // .library(name: "WebGL1", targets: ["WebGL1"]),
        // .library(name: "WebGL2", targets: ["WebGL2"]),
        // .library(name: "WebGPU", targets: ["WebGPU"]),
        // .library(name: "Gamepad", targets: ["Gamepad"]),
        // .library(name: "CSSOM", targets: ["CSSOM"]),
        // .library(name: "SVG", targets: ["SVG"]),
        // .library(name: "FileSystem", targets: ["FileSystem"]),

        // .executable(name: "WebIDLToSwift", targets: ["WebIDLToSwift"]),
    ],
    dependencies: [
        .package(url: "https://github.com/swiftwasm/JavaScriptKit", from: "0.22.2"),

        .package(url: "https://github.com/tayloraswift/swift-io", from: "0.1.0"),
        .package(url: "https://github.com/tayloraswift/swift-json", from: "1.2.0"),
    ],
    targets: [
        // .executableTarget(
        //     name: "WebAPIKitDemo",
        //     dependencies: ["DOM", "WebGL2"]
        // ),

        /*
        .target(name: "WebAPIBase",
            dependencies: [
                "ECMAScript"
            ]),
        .target(name: "DOM",
            dependencies: [
                "WebAPIBase",
                "ECMAScript",
            ]),
        .target(name: "WebSockets",
            dependencies: [
                "DOM",
                "WebAPIBase",
                "ECMAScript",
            ]),
        .target(name: "WebAudio",
            dependencies: [
                "DOM",
                "WebAPIBase",
                "ECMAScript",
            ]),
        .target(name: "WebAnimations",
            dependencies: [
                "DOM",
                "WebAPIBase",
                "WebAudio",
                "ECMAScript",
            ]),
        .target(name: "WebGL1",
            dependencies: [
                "DOM",
                "WebAPIBase",
                "WebAudio",
                "WebAnimations",
                "ECMAScript",
            ]),
        .target(name: "WebGL2",
            dependencies: [
                "DOM",
                "WebAPIBase",
                "WebAudio",
                "WebAnimations",
                "WebGL1",
                "ECMAScript",
            ]),
        .target(name: "WebGPU",
            dependencies: [
                "DOM",
                "WebAPIBase",
                "WebAudio",
                "WebAnimations",
                "WebGL1",
                "ECMAScript",
            ]),
        .target(name: "Gamepad",
            dependencies: [
                "DOM",
                "WebAPIBase",
                "ECMAScript"
            ]),
        .target(name: "CSSOM",
            dependencies: [
                "DOM",
                "WebAPIBase",
                "SVG",
                "ECMAScript"
            ]),
        .target(name: "SVG",
            dependencies: [
                "DOM",
                "WebAPIBase",
                "ECMAScript"
            ]),
        .target(name: "FileSystem",
            dependencies: [
                "DOM",
                "WebAPIBase",
                "ECMAScript"
            ]),
        */
        // This support library should be moved to JavaScriptKit
        .target(name: "ECMAScript", dependencies: [
            "JavaScriptKit",
            .product(name: "JavaScriptEventLoop", package: "JavaScriptKit"),
            .product(name: "JavaScriptBigIntSupport", package: "JavaScriptKit"),
        ]),

        .executableTarget(name: "WebIDL_",
            dependencies: [
                .target(name: "WebIDL"),

                .product(name: "System_ArgumentParser", package: "swift-io"),
                .product(name: "SystemIO", package: "swift-io"),
                .product(name: "JSON", package: "swift-json"),
            ]),

        .target(name: "WebIDL",
            dependencies: [
                .product(name: "JSON", package: "swift-json"),
            ]),
        /*

        .executableTarget(
            name: "WebIDLToSwift",
            dependencies: ["WebIDL"]
        ),

        .testTarget(
            name: "WebAPIKitTests",
            dependencies: ["DOM"]
        ),
        */
    ])
