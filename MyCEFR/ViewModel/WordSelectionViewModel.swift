//
//  WordSelectionViewModel.swift
//  MyCEFR
//
//  Created by Лаборатория on 12.11.2023.
//

import Foundation
//import AVFoundation

final class WordSelectionViewModel: ObservableObject{

    let words: [Word]
    let level: Level
    @Published var isSelectedWords = false

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

    func wordsInAGroup() -> String {
        let wordsText = "".declinationText(words.count, "wordsOne".localized, "wordsTwo".localized, "wordsThree".localized)
        return "wordsInAGroup".localized + " \(words.count) " + wordsText
    }

    func isSelectedWordsTogle(selectedWordsID: SelectedWordsID) {
        guard !words.isEmpty else {
            isSelectedWords = false
            return
        }
        for word in words {
            if selectedWordsID.selectedID.contains(word.id) {
                isSelectedWords = true
                return
            }
        }
        isSelectedWords = false
    }

    func howManyWordsAreSelected(selectedWordsID: SelectedWordsID) -> String {
        var countSelected = 0
        for word in words {
            if selectedWordsID.selectedID.contains(word.id) {
                countSelected += 1
            }
        }
        let wordsText = "".declinationText(countSelected, "wordsOne".localized, "wordsTwo".localized, "wordsThree".localized)
        return "selected".localized + ": \(countSelected) " + wordsText
    }

    func soundButtonAction(index: Int) {
        Speaker.shared.speak(msg: words[index].word)
    }
}
