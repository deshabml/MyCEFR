//
//  SuccessfullyLearnedWords.swift
//  MyCEFR
//
//  Created by Лаборатория on 18.12.2023.
//

import Foundation

struct SuccessfullyLearnedWordsID: Identifiable {

    var id: String
    var selectedID: [String]
}

extension SuccessfullyLearnedWordsID {

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
