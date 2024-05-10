//
//  WKWebViewApp.swift
//  WKWebView
//
//  Created by Nataliya Lazouskaya on 09/05/2024.
//

import ComposableArchitecture
import SwiftUI

@main
struct WKWebViewApp: App {
    var body: some Scene {
        WindowGroup {
            RootView(store: Store(initialState: RootFeature.State()) {
                RootFeature()
            })
        }
    }
}
