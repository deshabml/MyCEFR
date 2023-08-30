//
//  Group.swift
//  MyCEFR
//
//  Created by Лаборатория on 28.08.2023.
//

import Foundation

struct Group: Identifiable {

    var id: String = UUID().uuidString
    var name: String

}

extension Group {

    var representation: [String: Any] {
        var dict: [String: Any] = [:]
        dict["id"] = self.id
        dict["name"] = self.name
        return dict
    }

    init?(data: [String: Any]) {
        guard let id: String = data["id"] as? String,
              let name: String = data["name"] as? String else { return nil }
        self.id = id
        self.name = name
    }

}
