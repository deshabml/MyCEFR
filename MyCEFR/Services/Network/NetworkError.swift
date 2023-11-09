//
//  NetworkError.swift
//  MyCEFR
//
//  Created by Лаборатория on 08.11.2023.
//

enum NetworkError: Error {

    case badUrl
    case badResponse
    case invalidDecoding
    case noImage
}
