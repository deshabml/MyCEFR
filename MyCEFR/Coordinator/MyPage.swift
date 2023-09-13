//
//  MyPage.swift
//  MyCEFR
//
//  Created by Лаборатория on 12.09.2023.
//

import Foundation

// enum MyPage: String, CaseIterable, Identifiable {

//    case authorization, selectLevel, profileSettings(userProfile: UserProfile)

//    var id: String {self.rawValue}

// }

enum MyPage: Hashable, Identifiable {

    case authorization
    case selectLevel
    case profileSettings

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
        }
    }

}
