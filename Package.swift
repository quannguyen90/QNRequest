// swift-tools-version:5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "QNRequest",
    products: [
       .library(name: "QNRequest", targets: ["QNRequest"])
   ],
   targets: [
       .target(
           name: "QNRequest",
           path: "QNRequest"
       )
   ]
)
