//
//  MyPage.swift
//  MyCEFR
//
//  Created by Лаборатория on 12.09.2023.
//

import Foundation

enum MyPage: Hashable, Identifiable {

    case authorization
    case selectLevel
    case profileSettings
    case level
    case wordGroup
    case wordSelection

    var id: String {
        String(describing: self)
    }

    static func == (lhs: MyPage, rhs: MyPage) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        switch self {
            case .authorization:
                hasher.combine("authorization")
            case .selectLevel:
                hasher.combine("selectLevel")
            case .profileSettings:
                hasher.combine("profileSettings")
            case .level:
                hasher.combine("level")
            case .wordGroup:
                hasher.combine("wordGroup")
            case .wordSelection:
                hasher.combine("wordSelection")
        }
    }
}
