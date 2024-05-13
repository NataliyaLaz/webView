//
//  WebBrowserViewModel.swift
//  WKWebView
//
//  Created by Nataliya Lazouskaya on 13/05/2024.
//

import Foundation
import WebKit
import OSLog

class WebBrowserViewModel: NSObject, ObservableObject, WKNavigationDelegate {
    @Published var urlString = "http://onliner.by"
    @Published var canGoBack = false
    @Published var canGoForward = false
    @Published var isLoading = false
    @Published var error: Error?
    
    weak var webView: WKWebView? {
        didSet {
            webView?.navigationDelegate = self
        }
    }

    func loadURLString() {
        if let url = URL(string: urlString) {
            webView?.load(URLRequest(url: url))
        }
    }

    func goBack() {
        webView?.goBack()
    }

    func goForward() {
        webView?.goForward()
    }

    func reload() {
        webView?.reload()
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        isLoading = true
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        Logger.webView.info("didFinish navigation with back \(webView.canGoBack) and forward \(webView.canGoForward)")
        isLoading = false
        canGoBack = webView.canGoBack
        canGoForward = webView.canGoForward
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        Logger.webView.error("loading error: \(error)")
        isLoading = false
        self.error = error
    }
    
    @objc func handleRefresh(_ sender: UIRefreshControl) {
        sender.endRefreshing()
        Logger.webView.info("refreshing...")
        webView?.reload()
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let url = navigationAction.request.url {
            Logger.webView.info("trying to redirect to \(url)")
            guard let host = url.host?.lowercased() else {
                Logger.webView.warning("No host")
                decisionHandler(.cancel)
                return
            }
            if !(host == "onliner.by" || host.hasSuffix(".onliner.by")), !url.absoluteString.contains("about:blank") {
                Logger.webView.warning("Not supported host")
                decisionHandler(.cancel)
            } else {
                urlString = navigationAction.request.url?.absoluteString ?? ""
                decisionHandler(.allow)
            }
        } else {
            decisionHandler(.cancel)
        }
    }
}
