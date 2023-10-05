//
//  SelectLevelViewModel.swift
//  MyCEFR
//
//  Created by Лаборатория on 07.06.2023.
//

import UIKit

class SelectLevelViewModel: ObservableObject {

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

    func uploadWord() {
//        Task {
//            for word in wordsA1 {
//                do {
//                    try await FirestoreService.shared.editWord(word: word, level: Level(id: "1",
//                                                                                        name: "А1",
//                                                                                        fullName: "Elementary"))
//                } catch { print(error.localizedDescription) }
//            }
//        }
    }

}
