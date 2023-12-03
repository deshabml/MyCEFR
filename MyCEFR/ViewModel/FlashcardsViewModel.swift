//
//  FlashcardsViewModel.swift
//  MyCEFR
//
//  Created by Лаборатория on 01.12.2023.
//

import Foundation

final class FlashcardsViewModel: ObservableObject {
    
    let words: [Word]
    let level: Level
    let flashcardVM = FlashcardViewModel()
    @Published var activeWords: [Word] = []

    init(words: [Word], level: Level) {
        self.words = words
        self.level = level
    }

    func fullNameLevel() -> String {
        guard !words.isEmpty else { return level.name }
        let fullName = words[0].groupName
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

    func setupActiveWord(selectedWordsID: SelectedWordsID) {
        for word in words {
            if selectedWordsID.selectedID.contains(word.id) {
                activeWords.append(word)
            }
        }
        guard activeWords.isEmpty else {
            flashcardVM.setupWord(word: activeWords[0], isFirst: true)
            return
        }
        activeWords = words
        flashcardVM.setupWord(word: activeWords[0], isFirst: true)
    }

    func shuffle() {
        let newActiveWords = activeWords.shuffled()
        activeWords = newActiveWords
        flashcardVM.setupWord(word: activeWords[0], isFirst: true)
    }
}
