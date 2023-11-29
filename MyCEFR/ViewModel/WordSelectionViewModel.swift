//
//  WordSelectionViewModel.swift
//  MyCEFR
//
//  Created by Лаборатория on 12.11.2023.
//

import Foundation

final class WordSelectionViewModel: ObservableObject{

    let words: [Word]
    let level: Level

    init(words: [Word], level: Level) {
        self.words = words
        self.level = level
    }

    func fullNameLevel() -> String {
        guard !words.isEmpty else { return level.name }
        let fullName = level.name + "-" + words[0].groupName
        guard fullName.count > 20 else { return fullName }
        let fullNameArray = fullName.components(separatedBy: " ")
        var newFullName = ""
        for word in fullNameArray {
            let sentenceLength = (newFullName.count + word.count + 1) <= 20
            if sentenceLength {
                newFullName += " \(word)"
            } else {
                newFullName +=  " ..."
                break
            }
        }
        return newFullName
    }

    func isSelectedWord(index: Int, selectedWordsID: SelectedWordsID) -> Bool {
        selectedWordsID.selectedID.contains(words[index].id)
    }
}
