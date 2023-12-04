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
    @Published var successfulWordsID: [String] = []
    @Published var unsuccessfulWordsID: [String] = []
    @Published var activeWordIndex = 0
    @Published var isEnToRus: Bool = true

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
            flashcardVM.setupWord(word: activeWords[activeWordIndex], isFirst: true)
            return
        }
        activeWords = words
        flashcardVM.setupWord(word: activeWords[activeWordIndex], isFirst: true)
    }

    func shuffle() {
        let newActiveWords = activeWords.shuffled()
        activeWords = newActiveWords
        resettingCounters()
        activeWordIndex = 0
        flashcardVM.flipped = false
        flashcardVM.setupWord(word: activeWords[activeWordIndex], isFirst: true)
    }

    func reload() {
        resettingCounters()
        activeWordIndex = 0
        flashcardVM.setupWord(word: activeWords[activeWordIndex], isFirst: true)
    }

    func progressInfoText() -> String {
        "\(activeWordIndex + 1)/\(activeWords.count)"
    }

    func isEnToRusToggle() {
        isEnToRus.toggle()
        flashcardVM.isEnToRus = isEnToRus
        reload()
    }

    func resettingCounters() {
        successfulWordsID = []
        unsuccessfulWordsID = []
    }

    func swipe(isLeft: Bool) {
        guard activeWordIndex < (activeWords.count - 1) else { return }
        if isLeft {
            unsuccessfulWordsID.append(activeWords[activeWordIndex].id)
        } else {
            successfulWordsID.append(activeWords[activeWordIndex].id)
        }
        activeWordIndex += 1
        flashcardVM.activeWord = activeWords[activeWordIndex]
    }

    func isSelectedWord(selectedWordsID: SelectedWordsID) -> Bool {
        guard !activeWords.isEmpty else { return false }
        return selectedWordsID.selectedID.contains(activeWords[activeWordIndex].id)
    }
}
