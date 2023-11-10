//
//  Level.swift
//  MyCEFR
//
//  Created by Лаборатория on 19.09.2023.
//

import Foundation

struct Level: Identifiable {

    var id: String
    var name: String
    var fullName: String
}

extension Level {

    var representation: [String: Any] {
        var dict: [String: Any] = [:]
        dict["id"] = self.id
        dict["name"] = self.name
        dict["fullName"] = self.fullName
        return dict
    }

    init?(data: [String: Any]) {
        guard let id: String = data["id"] as? String,
              let name: String = data["name"] as? String,
              let fullName: String = data["fullName"] as? String else { return nil }
        self.id = id
        self.name = name
        self.fullName = fullName
    }
}
