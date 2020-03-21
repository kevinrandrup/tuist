// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "tuist",
    platforms: [.macOS(.v10_12)],
    products: [
        .executable(name: "tuist", targets: ["tuist"]),
        .executable(name: "tuistenv", targets: ["tuistenv"]),
        .library(name: "ProjectDescription",
                 type: .dynamic,
                 targets: ["ProjectDescription"]),

        /// TuistGenerator
        ///
        /// A high level Xcode generator library
        /// responsible for generating Xcode projects & workspaces.
        ///
        /// This library can be used in external tools that wish to
        /// leverage Tuist's Xcode generation features.
        ///
        /// Note: This library should be treated as **unstable** as
        ///       it is still under development and may include breaking
        ///       changes in future releases.
        .library(name: "TuistGenerator",
                 targets: ["TuistGenerator"]),
    ],
    dependencies: [
        .package(url: "https://github.com/tuist/XcodeProj", .upToNextMajor(from: "7.8.0")),
        .package(url: "https://github.com/apple/swift-package-manager", .upToNextMajor(from: "0.5.0")),
        .package(url: "https://github.com/IBM-Swift/BlueSignals", .upToNextMajor(from: "1.0.21")),
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "5.0.1")),
        .package(url: "https://github.com/rnine/Checksum.git", .upToNextMajor(from: "1.0.2")),
        .package(url: "https://github.com/apple/swift-log.git", .upToNextMajor(from: "1.2.0")),
        .package(url: "https://github.com/thii/xcbeautify.git", .upToNextMajor(from: "0.7.3")),
        .package(url: "https://github.com/krzyzanowskim/CryptoSwift", .upToNextMajor(from: "1.3.0")),
        .package(url: "https://github.com/stencilproject/Stencil", .branch("master")),
        .package(url: "https://github.com/evgenyneu/keychain-swift.git", .upToNextMajor(from: "19.0.0")),
        .package(url: "https://github.com/httpswift/swifter.git", .upToNextMajor(from: "1.4.7"))
    ],
    targets: [
        .target(
            name: "TuistCore",
            dependencies: ["SPMUtility", "TuistSupport", "XcodeProj"]
        ),
        .target(
            name: "TuistCoreTesting",
            dependencies: ["TuistCore", "TuistSupportTesting"]
        ),
        .testTarget(
            name: "TuistCoreTests",
            dependencies: ["TuistCore", "TuistCoreTesting", "TuistSupportTesting"]
        ),
        .testTarget(
            name: "TuistCoreIntegrationTests",
            dependencies: ["TuistCore", "TuistSupportTesting"]
        ),
        .target(
            name: "TuistKit",
            dependencies: ["XcodeProj", "SPMUtility", "TuistSupport", "TuistGenerator", "TuistCache", "TuistAutomation", "ProjectDescription", "Signals", "RxSwift", "RxBlocking", "Checksum", "TuistLoader", "TuistInsights", "TuistScaffold", "TuistSigning", "TuistCloud"]
        ),
        .testTarget(
            name: "TuistKitTests",
            dependencies: ["TuistKit", "TuistAutomation", "TuistSupportTesting", "TuistCoreTesting", "ProjectDescription", "RxBlocking", "TuistLoaderTesting", "TuistCacheTesting", "TuistGeneratorTesting", "TuistScaffoldTesting", "TuistCloudTesting"]
        ),
        .testTarget(
            name: "TuistKitIntegrationTests",
            dependencies: ["TuistKit", "TuistCoreTesting", "TuistSupportTesting", "ProjectDescription", "RxBlocking", "TuistLoaderTesting", "TuistCloudTesting"]
        ),
        .target(
            name: "tuist",
            dependencies: ["TuistKit", "ProjectDescription"]
        ),
        .target(
            name: "TuistEnvKit",
            dependencies: ["SPMUtility", "TuistSupport", "RxSwift", "RxBlocking"]
        ),
        .testTarget(
            name: "TuistEnvKitTests",
            dependencies: ["TuistEnvKit", "TuistSupportTesting"]
        ),
        .target(
            name: "tuistenv",
            dependencies: ["TuistEnvKit"]
        ),
        .target(
            name: "ProjectDescription",
            dependencies: []
        ),
        .testTarget(
            name: "ProjectDescriptionTests",
            dependencies: ["ProjectDescription", "TuistSupportTesting"]
        ),
        .target(
            name: "TuistSupport",
            dependencies: ["SPMUtility", "RxSwift", "RxRelay", "Logging", "KeychainSwift", "Swifter"]
        ),
        .target(
            name: "TuistSupportTesting",
            dependencies: ["TuistSupport", "SPMUtility"]
        ),
        .testTarget(
            name: "TuistSupportTests",
            dependencies: ["TuistSupport", "TuistSupportTesting", "RxBlocking"]
        ),
        .testTarget(
            name: "TuistSupportIntegrationTests",
            dependencies: ["TuistSupport", "TuistSupportTesting", "RxBlocking"]
        ),
        .target(
            name: "TuistGenerator",
            dependencies: ["XcodeProj", "SPMUtility", "TuistCore", "TuistSupport"]
        ),
        .target(
            name: "TuistGeneratorTesting",
            dependencies: ["TuistGenerator", "TuistCoreTesting", "TuistSupportTesting"]
        ),
        .testTarget(
            name: "TuistGeneratorTests",
            dependencies: ["TuistGenerator", "TuistSupportTesting", "TuistCoreTesting", "TuistGeneratorTesting"]
        ),
        .testTarget(
            name: "TuistGeneratorIntegrationTests",
            dependencies: ["TuistGenerator", "TuistSupportTesting", "TuistCoreTesting", "TuistGeneratorTesting"]
        ),
        .target(
            name: "TuistCache",
            dependencies: ["XcodeProj", "SPMUtility", "TuistCore", "TuistSupport", "Checksum", "RxSwift"]
        ),
        .testTarget(
            name: "TuistCacheTests",
            dependencies: ["TuistCache", "TuistSupportTesting", "TuistCoreTesting", "RxBlocking"]
        ),
        .target(
            name: "TuistCacheTesting",
            dependencies: ["TuistCache", "SPMUtility", "TuistCore", "RxTest", "RxSwift"]
        ),
        .target(
            name: "TuistCloud",
            dependencies: ["XcodeProj", "SPMUtility", "TuistCore", "TuistSupport", "Checksum", "RxSwift"]
        ),
        .testTarget(
            name: "TuistCloudTests",
            dependencies: ["TuistCloud", "TuistSupportTesting", "TuistCoreTesting", "RxBlocking"]
        ),
        .target(
            name: "TuistCloudTesting",
            dependencies: ["TuistCloud", "SPMUtility", "TuistCore", "RxTest", "RxSwift"]
        ),
        .testTarget(
            name: "TuistCacheIntegrationTests",
            dependencies: ["TuistCache", "TuistSupportTesting", "RxBlocking", "TuistCoreTesting"]
        ),
        .target(
            name: "TuistScaffold",
            dependencies: ["SPMUtility", "TuistCore", "TuistSupport", "Stencil"]
        ),
        .target(
            name: "TuistScaffoldTesting",
            dependencies: ["TuistScaffold"]
        ),
        .testTarget(
            name: "TuistScaffoldTests",
            dependencies: ["TuistScaffold", "TuistSupportTesting", "TuistCoreTesting"]
        ),
        .testTarget(
            name: "TuistScaffoldIntegrationTests",
            dependencies: ["TuistScaffold", "TuistSupportTesting"]
        ),
        .target(
            name: "TuistAutomation",
            dependencies: ["XcodeProj", "SPMUtility", "TuistCore", "TuistSupport", "XcbeautifyLib"]
        ),
        .testTarget(
            name: "TuistAutomationTests",
            dependencies: ["TuistAutomation", "TuistSupportTesting"]
        ),
        .testTarget(
            name: "TuistAutomationIntegrationTests",
            dependencies: ["TuistAutomation", "TuistSupportTesting"]
        ),
        .target(
            name: "TuistInsights",
            dependencies: ["XcodeProj", "SPMUtility", "TuistCore", "TuistSupport", "XcbeautifyLib"]
        ),
        .testTarget(
            name: "TuistInsightsTests",
            dependencies: ["TuistInsights", "TuistSupportTesting"]
        ),
        .testTarget(
            name: "TuistInsightsIntegrationTests",
            dependencies: ["TuistInsights", "TuistSupportTesting"]
        ),
        .target(
            name: "TuistSigning",
            dependencies: ["TuistCore", "TuistSupport", "CryptoSwift"]
        ),
        .testTarget(
            name: "TuistSigningTests",
            dependencies: ["TuistSigning", "TuistSupportTesting", "TuistCoreTesting"]
        ),
        .target(
            name: "TuistLoader",
            dependencies: ["XcodeProj", "SPMUtility", "TuistCore", "TuistSupport", "ProjectDescription"]
        ),
        .target(
            name: "TuistLoaderTesting",
            dependencies: ["TuistLoader", "SPMUtility", "TuistCore", "ProjectDescription"]
        ),
        .testTarget(
            name: "TuistLoaderTests",
            dependencies: ["TuistLoader", "TuistSupportTesting", "TuistLoaderTesting", "TuistCoreTesting"]
        ),
        .testTarget(
            name: "TuistLoaderIntegrationTests",
            dependencies: ["TuistLoader", "TuistSupportTesting", "ProjectDescription"]
        ),
        .testTarget(
            name: "TuistIntegrationTests",
            dependencies: ["TuistGenerator", "TuistSupportTesting", "TuistSupport", "TuistCoreTesting"]
        ),
    ]
)
