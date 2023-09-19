//
//  SelectLevelViewModel.swift
//  MyCEFR
//
//  Created by Лаборатория on 07.06.2023.
//

import UIKit

class SelectLevelViewModel: ObservableObject {

    @Published var levels: [Level] = []

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

}
