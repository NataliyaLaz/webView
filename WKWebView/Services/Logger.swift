//
//  Logger.swift
//  WKWebView
//
//  Created by Nataliya Lazouskaya on 13/05/2024.
//

import Foundation
import OSLog

extension Logger {
    private static var subsystem = Bundle.main.bundleIdentifier
    
    static let webView = Logger(subsystem: subsystem ?? "", category: "webView")
}
