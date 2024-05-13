//
//  WebView.swift
//  WKWebView
//
//  Created by Nataliya Lazouskaya on 09/05/2024.
//

/*import ComposableArchitecture
import SwiftUI

struct WebScreenView: View {
    
    @Perception.Bindable var store: StoreOf<WebScreenFeature>
    
    var body: some View {
        WithPerceptionTracking {
            VStack {
                if let urlString = store.link, let url = URL(string: urlString) {
                    Button("Go Back", action: {
                        store.send(.goBack)
                    })
                    .disabled(!store.canGoBack)
                    WebView(url: url,
                            cachePolicy: .returnCacheDataElseLoad,
                            onCanGoBackChanged: { canGoBack in
                        store.send(.setCanGoBack(canGoBack))
                    },
                            onNavigationAction: { url, blockNavigation in
                        guard let host = url.host?.lowercased() else {
                            debugPrint("No host")
                            blockNavigation()
                            return false
                        }
                        debugPrint("Host \(host)")
                        if !(host == "onliner.by" || host.hasSuffix(".onliner.by")), !url.absoluteString.contains("about:blank") {
                            blockNavigation()
                            store.send(.closeWebView)
                            return false
                        }
                        return true
                    },
                            navigateBack: $store.navigateBack, 
                            isLoading: $store.isLoading, 
                            onRefresh: {
                        store.send(.refreshWebView)
                    })
                    .scrollIndicators(.hidden)
                    .padding()
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.gray, lineWidth: 1)
                    )
                } else {
                    Button(action: {
                        store.send(.onAppear)
                    }, label: {
                        Text("Could not be presented, please refresh")
                    })
                }
            }
            .padding()
            .onAppear {
                store.send(.onAppear)
            }
        }
    }
}*/
