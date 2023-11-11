//
//  WordSelectionViewModel.swift
//  MyCEFR
//
//  Created by Лаборатория on 12.11.2023.
//

import Foundation

final class WordSelectionViewModel: ObservableObject {

    let words: [Word]
    let level: Level

    init(words: [Word], level: Level) {
        self.words = words
        self.level = level
    }

    func fullNameLevel() -> String {
        guard !words.isEmpty else { return level.name }
        return level.name + "-" + words[0].groupName
    }
}
