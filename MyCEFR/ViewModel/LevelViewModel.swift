//
//  LevelViewModel.swift
//  MyCEFR
//
//  Created by Лаборатория on 09.11.2023.
//

import Foundation

final class LevelViewModel: ObservableObject {

    let level: Level

    init(level: Level) {
        self.level = level
    }

    func fullNameLevel() -> String {
        level.name + "\n" + level.fullName
    }
}
