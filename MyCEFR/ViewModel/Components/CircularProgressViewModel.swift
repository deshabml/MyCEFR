//
//  CircularProgressViewModel.swift
//  MyCEFR
//
//  Created by Лаборатория on 15.09.2023.
//

import Foundation

final class CircularProgressViewModel: ObservableObject {

    @Published var progress: Double = 0

    func setup(progress: Double) {
        self.progress = progress
    }
}
