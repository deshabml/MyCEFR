//
//  SelectLevelViewModel.swift
//  MyCEFR
//
//  Created by Лаборатория on 07.06.2023.
//

import UIKit

final class SelectLevelViewModel: ObservableObject {

    @Published var levels: [Level] = []
    var wordsA1: [Word] = []

    init() {
        getLevels()
    }

    func getLevels() {
        Task {
            do {
                let levels = try await FirestoreService.shared.getlevels()
                DispatchQueue.main.async {
                    self.levels = levels
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func downloadJson() {
        Task {
            do {
                let words = try await NetworkServiceAA.shared.getData(dataset: [JSONWord(word: "", translation: "", transcription: "", partOfSpeech: "")])
                for word in words {
                    wordsA1.append(Word(groupID: "48", groupName: "Work", word: word.word, translation: word.translation, transcription: word.transcription, partOfSpeechID: word.partOfSpeech))
                    print(wordsA1)
                }
            } catch { 
                print(error.localizedDescription)
            }
        }
    }

    func uploadWord() {
//        Task {
//            for word in wordsA1 {
//                do {
//                    try await FirestoreService.shared.editWord(word: word, level: Level(id: "4",
//                                                                                        name: "B2",
//                                                                                        fullName: "Upper-Intermediate"))
//                } catch {
//                    print(error.localizedDescription)
//                }
//            }
//        }
    }
}
