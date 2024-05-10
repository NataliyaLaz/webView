//
//  LinkService.swift
//  WKWebView
//
//  Created by Nataliya Lazouskaya on 09/05/2024.
//

import Foundation
import ComposableArchitecture

@DependencyClient
public struct LinkService: Sendable {
    var getLink: @Sendable () async throws -> String?
}

extension LinkService: DependencyKey {
    public static var liveValue: Self {
        
        return Self(
            getLink: {
                try await getLink()
            }
        )
        
        @Sendable
        func getLink() async throws -> String? {
            let link = "http://onliner.by"
        //    let link = "http://http.badssl.com/"
            return link
        }
    }
}

extension LinkService: TestDependencyKey {
    public static let testValue = Self()
}

extension DependencyValues {
    public var linkService: LinkService {
        get { self[LinkService.self] }
        set { self[LinkService.self] = newValue }
    }
}

