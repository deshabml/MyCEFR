//
//  LearningViewModel.swift
//  MyCEFR
//
//  Created by Лаборатория on 06.12.2023.
//

import Foundation

final class LearningViewModel: ObservableObject {

    let words: [Word]
    let level: Level
    @Published var activeWords: [Word] = []
    @Published var activeWordIndex = 0
    @Published var isEnToRus: Bool = true
    @Published var successfulWordsID: [String] = []
    @Published var unsuccessfulWordsID: [String] = []

    init(words: [Word], level: Level) {
        self.words = words
        self.level = level
    }

    func setupActiveWord(selectedWordsID: SelectedWordsID) {
        for word in words {
            if selectedWordsID.selectedID.contains(word.id) {
                activeWords.append(word)
            }
        }
        print(activeWords)
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

    func activeWordText() -> String {
        guard !activeWords.isEmpty else { return "" }
        if isEnToRus {
            return activeWords[activeWordIndex].word
        } else {
            return activeWords[activeWordIndex].translation
        }
    }

    func isEnToRusToggle() {
        isEnToRus.toggle()
        reload()
    }

    func reload() {
        resettingCounters()
        activeWordIndex = 0
    }

    func resettingCounters() {
        successfulWordsID = []
        unsuccessfulWordsID = []
    }

    func progressInfoText() -> String {
        "\(activeWordIndex + 1)/\(activeWords.count)"
    }
}
