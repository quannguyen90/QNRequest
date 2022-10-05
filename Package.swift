// swift-tools-version:5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "QNRequest",
    products: [
        .library(name: "QNRequest", targets: ["QNRequest"])
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", from: "4.9.1")
    ],
    targets: [
        .target(
            name: "QNRequest",
            dependencies: [
                .product(name: "Alamofire", package: "Alamofire")
            ], path: "QNRequest"
        )
    ],
    swiftLanguageVersions: [.v4, .v5]
)



//let package = Package(
//    name: "Alamofire",
//    products: [
//        .library(
//            name: "Alamofire",
//            targets: ["Alamofire"])
//    ],
//    targets: [
//        .target(
//            name: "Alamofire",
//            path: "Source")
//    ],
//    swiftLanguageVersions: [.v4, .v5]
//)
