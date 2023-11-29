//
//  SelectedWordsID.swift
//  MyCEFR
//
//  Created by Лаборатория on 29.11.2023.
//

import Foundation

struct SelectedWordsID: Identifiable {

    var id: String
    var selectedID: [String]
}

extension SelectedWordsID {

    var representation: [String: Any] {
        var dict: [String: Any] = [:]
        dict["id"] = self.id
        dict["selectedID"] = self.selectedID
        return dict
    }

    init?(data: [String: Any]) {
        guard let id: String = data["id"] as? String,
              let selectedID: [String] = data["selectedID"] as? [String] else { return nil }
        self.id = id
        self.selectedID = selectedID
    }
}
