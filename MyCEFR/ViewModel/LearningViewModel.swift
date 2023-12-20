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
    var completion: (([String]) -> ())?
    @Published var activeWords: [Word] = []
    @Published var activeWordIndex = 0
    @Published var isEnToRus: Bool = false
    @Published var successfulWordsID: [String] = [] {
        didSet {
            isSuccessfully = if isEnToRus {
                false
            } else {
                successfulWordsID.count == activeWords.count
            }
        }
    }
    @Published var unsuccessfulWordsID: [String] = []
    @Published var activeUserResponseText = "" {
        didSet {
            checkText(text: activeUserResponseText)
        }
    }
    @Published var showUnsuccessfulWordsAnimation = false
    @Published var showSuccessfulWordsAnimation = false
    @Published var showTextField = true
    @Published var isFinishedRound = false {
        didSet {
            if isSuccessfully, isFinishedRound {
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500))  { [unowned self] in
                    self.fireworkCounter += 1
                }
            }
        }
    }
    @Published var isSuccessfully = false {
        didSet {
            if isSuccessfully {
                completion?(successfulWordsID)
            }
        }
    }
    @Published var fireworkCounter = 0

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
        guard activeWords.isEmpty else { return }
        activeWords = words
    }

    func setupCompletion(completion: @escaping ([String]) -> ()) {
        self.completion = completion
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

    func restartRound() {
        reload()
        isFinishedRound = false
    }

    func progressInfoText() -> String {
        "\(activeWordIndex + 1)/\(activeWords.count)"
    }

    func soundButtonAction() {
        Speaker.shared.speak(msg: activeWords[activeWordIndex].word)
    }

    func dontKnowButtonAction() {
        unsuccessfulWordsID.append(activeWords[activeWordIndex].word)
        guard activeWordIndex < activeWords.count - 1 else {
            isFinishedRound = true
            return
        }
        activeUserResponseText = ""
        activeWordIndex += 1
    }

    func successfulNextWord() async {
        DispatchQueue.main.async { [unowned self] in
            self.showUnsuccessfulWordsAnimation = false
            self.showSuccessfulWordsAnimation = true
            self.successfulWordsID.append(self.activeWords[self.activeWordIndex].id)
        }
        guard activeWordIndex < activeWords.count - 1 else {
            DispatchQueue.main.async { [unowned self] in
                self.isFinishedRound = true
            }
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) { [unowned self] in
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

    func isCoorectWord(index: Int) -> Bool {
        guard successfulWordsID.contains(activeWords[index].id) else { return false }
        return true
    }
}
