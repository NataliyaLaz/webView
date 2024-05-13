//
//  WebBrowserView.swift
//  WKWebView
//
//  Created by Nataliya Lazouskaya on 13/05/2024.
//

import Foundation
import SwiftUI
import WebKit

struct WebBrowserView: View {

    @StateObject var webBrowserViewModel = WebBrowserViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    webBrowserViewModel.goBack()
                }) {
                    Image(systemName: "chevron.backward")
                }
                .disabled(!webBrowserViewModel.canGoBack)

                Button(action: {
                    webBrowserViewModel.goForward()
                }) {
                    Image(systemName: "chevron.forward")
                }
                .disabled(!webBrowserViewModel.canGoForward)

                .padding(.trailing, 5)

                TextField("URL", text: $webBrowserViewModel.urlString, onCommit: {
                    webBrowserViewModel.loadURLString()
                 })
                 .textFieldStyle(RoundedBorderTextFieldStyle())

                Button(action: {
                    webBrowserViewModel.reload()
                }) {
                    Image(systemName: "arrow.clockwise")
                }
            }
            .padding(.horizontal)
            if let error = webBrowserViewModel.error {
                Text(error.localizedDescription)
            } else if let url =  URL(string: webBrowserViewModel.urlString) {
                ZStack{
                    BrowserWebView(url: url,
                                   viewModel: webBrowserViewModel)
                    .edgesIgnoringSafeArea(.all)
                    if webBrowserViewModel.isLoading {
                        ProgressView()
                    }
                }
            } else {
                Text("Please, enter a url.")
            }
        }
    }
}

struct BrowserWebView: UIViewRepresentable {
    let url: URL
    @ObservedObject var viewModel: WebBrowserViewModel
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        viewModel.webView = webView
        webView.load(URLRequest(url: url))
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(viewModel, action: #selector(viewModel.handleRefresh), for: .valueChanged)
        webView.scrollView.refreshControl = refreshControl
        return webView
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
}
