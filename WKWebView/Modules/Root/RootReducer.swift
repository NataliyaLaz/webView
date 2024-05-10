//
//  RootReducer.swift
//  WKWebView
//
//  Created by Nataliya Lazouskaya on 09/05/2024.
//

import Foundation
import ComposableArchitecture

@Reducer
struct RootFeature {
    
    @Reducer
    enum Path {
        case webView(WebScreenFeature)
    }
    
    @ObservableState
    struct State {
        var isPresenting: Bool = false
        var path = StackState<Path.State>()
    }
    
    enum Action {
        case onAppear
        case openTapped
        case path(StackAction<Path.State, Path.Action>)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                case .onAppear:
                    return .none
                case .openTapped:
                    state.path.append(.webView(WebScreenFeature.State()))
                    return .none
                case .path:
                    return .none
            }
        }
        .forEach(\.path, action: \.path)
    }
}
