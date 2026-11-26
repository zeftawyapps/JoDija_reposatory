// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.
//
// Generated file. Do not edit.
//

import PackageDescription

let package = Package(
    name: "FlutterGeneratedPluginSwiftPackage",
    platforms: [
        .macOS("12.0")
    ],
    products: [
        .library(name: "FlutterGeneratedPluginSwiftPackage", type: .static, targets: ["FlutterGeneratedPluginSwiftPackage"])
    ],
    dependencies: [
        .package(name: "firebase_core", path: "../.packages/firebase_core"),
        .package(name: "cloud_firestore", path: "../.packages/cloud_firestore-7.1.0"),
        .package(name: "firebase_auth", path: "../.packages/firebase_auth-7.0.1"),
        .package(name: "firebase_messaging", path: "../.packages/firebase_messaging-17.0.1"),
        .package(name: "firebase_storage", path: "../.packages/firebase_storage-14.0.1"),
        .package(name: "google_sign_in_ios", path: "../.packages/google_sign_in_ios-6.3.8"),
        .package(name: "FlutterFramework", path: "../.packages/FlutterFramework")
    ],
    targets: [
        .target(
            name: "FlutterGeneratedPluginSwiftPackage",
            dependencies: [
                .product(name: "firebase-core", package: "firebase_core"),
                .product(name: "cloud-firestore", package: "cloud_firestore"),
                .product(name: "firebase-auth", package: "firebase_auth"),
                .product(name: "firebase-messaging", package: "firebase_messaging"),
                .product(name: "firebase-storage", package: "firebase_storage"),
                .product(name: "google-sign-in-ios", package: "google_sign_in_ios"),
                .product(name: "FlutterFramework", package: "FlutterFramework")
            ]
        )
    ]
)
