//
//  URLManager.swift
//  MyCEFR
//
//  Created by Лаборатория on 08.11.2023.
//

import Foundation

final class URLManager {

    static let shared = URLManager()
    private let tunnel = "https://"
    private let server = Server.prod

    private init() { }

    func createUrl(endpoint: EndPoint) -> URL? {
        let urlStr = tunnel + server.rawValue + endpoint.rawValue
        return URL(string: urlStr)
    }
}

enum Server: String {

    case prod = "run.mocky.io"
}

enum EndPoint: String {

    case words = "/v3/630982f9-a05f-4025-bc48-8b2beae36d70"
}
