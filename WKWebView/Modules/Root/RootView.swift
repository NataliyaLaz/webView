//
//  ContentView.swift
//  WKWebView
//
//  Created by Nataliya Lazouskaya on 09/05/2024.
//

import ComposableArchitecture
import SwiftUI

struct RootView: View {
    @Perception.Bindable var store: StoreOf<RootFeature>
    var body: some View {
        WithPerceptionTracking {
            NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
                VStack {
                    Button(action: {
                        store.send(.openTapped)
                    }, label: {
                        Text("Open WebView")
                    })
                }
                .padding()
                .onAppear {
                    store.send(.onAppear)
                }
            } destination: { store in
                switch store.case {
                    case .webView (let store):
                        WebScreenView(store: store)
                }
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        let state = RootFeature.State()
        
        RootView(store: Store(initialState: state, reducer: {
            RootFeature()
        }))
        .previewDisplayName("Unknown")
    }
}

