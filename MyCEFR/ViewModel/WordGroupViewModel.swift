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
        var nameGroup = ""
        var partNuber = 1
        let roomNumbers = ["I", "II", "III", "IV", "V", "VI", "VII", "VII", "X", "XI", "XII"]
        for index in 0 ..< wordsGroup.count {
            if nameGroup == wordsGroup[index].group.name {
                partNuber += 1
                if partNuber < 13 {
                    wordsGroup[index].group.name = nameGroup + " - part " + roomNumbers[partNuber - 1]
                } else {
                    wordsGroup[index].group.name = nameGroup + " - part \(partNuber)"
                }
            } else {
                partNuber = 1
                nameGroup = wordsGroup[index].group.name
            }
        }
    }

    func selectionWords(group: Group) -> [Word] {
        words.filter { $0.groupID == group.id }
    }
}
