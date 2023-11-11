//
//  WordGroupViewModel.swift
//  MyCEFR
//
//  Created by Лаборатория on 10.11.2023.
//

import Foundation

final class WordGroupViewModel: ObservableObject {
    
    let level: Level
    @Published var wordsGroup: [(group: Group, count: Int)] = []
    var words: [Word] = []

    init(level: Level) {
        self.level = level
        getWords()
    }

    func fullNameLevel() -> String {
        level.name + "\n" + "vocabulary".localized
    }

    private func getWords() {
        Task {
            do {
                let words = try await FirestoreService.shared.getWords(level: level)
                DispatchQueue.main.async { [unowned self] in
                    self.words = words
                    self.getWordsGroup()
                    print(self.wordsGroup)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    private func getWordsGroup() {
        let groups: [Group] = words.map { Group(id: $0.groupID, name: $0.groupName) }
        for group in Set(groups) {
            let oneGroups = groups.filter { $0 == group }
            wordsGroup.append((group: group, count: oneGroups.count))
            wordsGroup.sort { groupFirst, groupSecond in
                groupFirst.group.id < groupSecond.group.id
            }
        }
    }
}
