//
//  WebView.swift
//  WKWebView
//
//  Created by Nataliya Lazouskaya on 09/05/2024.
//

/*import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL
    let cachePolicy: URLRequest.CachePolicy
    var onCanGoBackChanged: (Bool) -> Void
    var onNavigationAction: (URL, @escaping () -> Void) -> Bool
    @Binding var navigateBack: Bool
    @Binding var isLoading: Bool
    var onRefresh: () -> Void
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(context.coordinator, action: #selector(Coordinator.handleRefresh), for: .valueChanged)
        webView.scrollView.refreshControl = refreshControl
        
        context.coordinator.webView = webView
        
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url, cachePolicy: cachePolicy)
        webView.load(request)
        
        if navigateBack && webView.canGoBack {
            webView.goBack()
            navigateBack = false
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self, webView: nil, onCanGoBackChanged: onCanGoBackChanged, onRefresh: onRefresh)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView
        var webView: WKWebView?
        var onCanGoBackChanged: (Bool) -> Void
        var onRefresh: () -> Void
        
        init(_ parent: WebView, webView: WKWebView?, onCanGoBackChanged: @escaping (Bool) -> Void, onRefresh: @escaping () -> Void) {
            self.parent = parent
            self.webView = webView
            self.onCanGoBackChanged = onCanGoBackChanged
            self.onRefresh = onRefresh
        }
        
        @objc func handleRefresh(_ sender: UIRefreshControl) {
            sender.endRefreshing()
            webView?.reload()
            onRefresh()
        }
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            debugPrint("TTT didStartProvisionalNavigation")
            parent.isLoading = true
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            debugPrint("TTT didFinish")
            parent.isLoading = false
            onCanGoBackChanged(webView.canGoBack)
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
}*/
