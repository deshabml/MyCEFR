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

    case words = "/v3/bb3d8cf0-425b-4fa3-a13d-0f80d7cc0243"
}
