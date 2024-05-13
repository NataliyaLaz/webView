//
//  WebScreenReducer.swift
//  WKWebView
//
//  Created by Nataliya Lazouskaya on 09/05/2024.
//

/*import Foundation
import ComposableArchitecture

@Reducer
struct WebScreenFeature {
    
    @ObservableState
    struct State {
        var link: String?
        var canGoBack: Bool = false
        var navigateBack: Bool = false
        var isLoading: Bool = false
        var refreshIsNeeded: Bool = false
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case onAppear
        case closeWebView
        case setLink(String?)
        case goBack
        case setCanGoBack(Bool)
        case navigateBackChanged(Bool)
        case refreshWebView
    }
    
    @Dependency(\.linkService) var linkService
    
    var body: some ReducerOf<Self> {
        BindingReducer()

        Reduce { state, action in
            switch action {
                case .onAppear:
                    return .run { send in
                        let link = try await linkService.getLink()
                        await send(.setLink(link))
                    } catch: { _, _ in }
                case .closeWebView:
                    debugPrint("closeWebView")
                    //   state.link = nil
                    return .none
                case .setLink(let link):
                    debugPrint("setLink \(link)")
                    state.link = link
                    return .none
                case .goBack:
                    debugPrint("goBack")
                    state.navigateBack = true
                    return .run { send in
                        try await Task.sleep(for: .seconds(1))
                        await send(.navigateBackChanged(false))
                    } catch: { _, _ in }
                case .setCanGoBack(let canGoBack):
                    debugPrint("setCanGoBack \(canGoBack)")
                    state.canGoBack = canGoBack
                    return .none
                case .navigateBackChanged(let navigateBack):
                    debugPrint("navigateBackChanged \(navigateBack)")
                    state.navigateBack = navigateBack
                    return .none
                case .refreshWebView:
                    debugPrint("Refresh is needed")
                    state.refreshIsNeeded = true
                    return .none
                case .binding:
                    return .none
            }
        }
    }
}*/
