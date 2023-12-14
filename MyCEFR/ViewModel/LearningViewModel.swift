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
    @Published var activeUserResponseText = "" {
        didSet {
            checkText(text: activeUserResponseText)
        }
    }
    @Published var showUnsuccessfulWordsAnimation = false
    @Published var showSuccessfulWordsAnimation = false
    @Published var showTextField = true


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
        activeUserResponseText = ""
    }

    func resettingCounters() {
        successfulWordsID = []
        unsuccessfulWordsID = []
    }

    func progressInfoText() -> String {
        "\(activeWordIndex + 1)/\(activeWords.count)"
    }

    func soundButtonAction() {
        Speaker.shared.speak(msg: activeWords[activeWordIndex].word)
    }

    func dontKnowButtonAction() {
        guard activeWordIndex < activeWords.count - 1 else { return }
        unsuccessfulWordsID.append(activeWords[activeWordIndex].word)
        activeUserResponseText = ""
        activeWordIndex += 1
    }

    func successfulNextWord() async {
        DispatchQueue.main.async { [unowned self] in
            self.showUnsuccessfulWordsAnimation = false
            self.showSuccessfulWordsAnimation = true
        }
        guard self.activeWordIndex < self.activeWords.count - 1 else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) { [unowned self] in
            self.successfulWordsID.append(self.activeWords[self.activeWordIndex].word)
            self.showTextField = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) { [unowned self] in
                self.showTextField = true
                self.activeUserResponseText = ""
            }
            self.activeWordIndex += 1
        }
    }

    func checkText(text: String) {
        guard !text.isEmpty else {
            showUnsuccessfulWordsAnimation = false
            showSuccessfulWordsAnimation = false
            return
        }
        let formatText = formattingTheText(text: text.lowercased())
        let formatActiveWordsRu = formattingTheText(text: activeWords[activeWordIndex].translation.lowercased())
        let formatActiveWordsEn = formattingTheText(text: activeWords[activeWordIndex].word.lowercased())
        if isEnToRus, formatText == formatActiveWordsRu {
            Task {
                await successfulNextWord()
            }
        } else if !isEnToRus, formatText == formatActiveWordsEn {
            Task {
                await successfulNextWord()
            }
        } else {
            showSuccessfulWordsAnimation = false
            showUnsuccessfulWordsAnimation = true
        }
    }

    func formattingTheText(text: String) -> String {
        var itogText = ""
        for character in text {
            guard character != "(" else {
                if itogText.last == " " {
                    itogText.removeLast()
                }
                return itogText
            }
            if character == "ё" {
                itogText += "е"
            } else {
                itogText += "\(character)"
            }
        }
        return itogText
    }
}
