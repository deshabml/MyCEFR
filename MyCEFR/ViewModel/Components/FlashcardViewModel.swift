//
//  FlashcardViewModel.swift
//  MyCEFR
//
//  Created by Лаборатория on 01.12.2023.
//

import Foundation

final class FlashcardViewModel: ObservableObject {
    
    @Published var flipped: Bool = false
    @Published var flashcardRotation = 0.1
    @Published var contentRotation = 0.1
    @Published var activeWord: Word = Word(groupID: "",
                                           groupName: "",
                                           word: "",
                                           translation: "",
                                           transcription: "",
                                           partOfSpeechID: "")
    @Published var isFirctWord = false
    @Published var isEnToRus = true {
        didSet {
            if isEnToRus {
                if flipped {
                    flipped.toggle()
                }
            } else {
                if flipped {
                    flipped.toggle()
                }
            }
        }
    }
    @Published var style: StyleCard = .standart
    var completionBackButten: (()->())?
    
    func setupWord(word: Word, isFirst: Bool = false) {
        self.activeWord = word
        isFirctWord = isFirst
    }
    
    enum StyleCard {
        
        case red
        case green
        case standart
    }
    
    func setupCompletionBackButten(_ completionBackButten: @escaping ()->()) {
        self.completionBackButten = completionBackButten
    }

    func soundButtonAction() {
        Speaker.shared.speak(msg: activeWord.word)
    }
}
