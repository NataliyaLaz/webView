//
//  WebView.swift
//  WKWebView
//
//  Created by Nataliya Lazouskaya on 09/05/2024.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    
    let url: URL
    let cachePolicy: URLRequest.CachePolicy
    @Binding var goBack: Bool
    var onNavigationAction: (URL, @escaping () -> Void) -> Bool
    
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url, cachePolicy: cachePolicy)
        webView.load(request)
        // Check if we need to navigate back
        if goBack && webView.canGoBack {
            webView.goBack()
            // Call the async method to reset goBack
            resetGoBack()
        }
    }
    
    private func resetGoBack() {
        Task {
            await MainActor.run {
                self.goBack = false
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView
        
        init(_ parent: WebView) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            debugPrint("Trying to redirect to \(navigationAction.request.url)")
            if let url = navigationAction.request.url {
                if self.parent.onNavigationAction(url, {
                    debugPrint("here is the callback URL is blocked")
                }) {
                    decisionHandler(.allow)
                } else {
                    decisionHandler(.cancel)
                }
            } else {
                decisionHandler(.cancel)
            }
        }
    }
}

extension WebView {
    func goBack(_ webView: WKWebView) {
        if webView.canGoBack {
            webView.goBack()
        }
    }
}

struct WebViewLoadable: ViewModifier {
    let url: URL
    let title: String
    let isFullScreen: Bool
    let cachePolicy: URLRequest.CachePolicy
    @Binding var isPresented: Bool
    @State private var navigateBack: Bool = false
    var onNavigationAction: (URL, @escaping () -> Void) -> Bool
    
    func body(content: Content) -> some View {
        if isFullScreen {
            content
                .navigationDestination(isPresented: $isPresented) {
                    webView()
                }
        } else {
            content
                .sheet(isPresented: $isPresented, content: {
                    webView()
                })
        }
    }
    
    private func webView() -> some View {
        NavigationView {
            WebView(url: url,
                    cachePolicy: cachePolicy,
                    goBack: $navigateBack,
                    onNavigationAction: { url, blockNavigation in
                if !isURLAllowed(url) {
                    blockNavigation()  // Block the navigation and handle the callback
                    return false
                }
                return true
            })  // Pass the Binding<Bool> for navigateBack
            .ignoresSafeArea(edges: .all)
            .navigationBarTitle(Text(title), displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        self.navigateBack = true  // Set navigateBack to true to trigger navigation back in WebView
                    }) {
                        Image(systemName: "chevron.left")  // Back button icon
                    }
                }
            }
        }
    }
    
    private func isURLAllowed(_ url: URL) -> Bool {
        guard let host = url.host?.lowercased() else {
            return false
        }
        return host == "onliner.by" || host.hasSuffix(".onliner.by") || url.absoluteString.contains("about:blank")
    }
}

extension View {
    func webViewLoadable(url: URL,
                         title: String,
                         isPresented: Binding<Bool>,
                         isFullScreen: Bool,
                         cachePolicy: URLRequest.CachePolicy = .returnCacheDataElseLoad,
                         onNavigationAction: @escaping (URL, @escaping () -> Void) -> Bool) -> some View {
        modifier(WebViewLoadable(url: url,
                                 title: title,
                                 isFullScreen: isFullScreen,
                                 cachePolicy: cachePolicy,
                                 isPresented: isPresented,
                                 onNavigationAction: onNavigationAction))
    }
}
