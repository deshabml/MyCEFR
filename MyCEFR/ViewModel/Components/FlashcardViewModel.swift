//
//  FlashcardViewModel.swift
//  MyCEFR
//
//  Created by Лаборатория on 01.12.2023.
//

import Foundation

final class FlashcardViewModel: ObservableObject {

    @Published var flipped: Bool = false
    @Published var flashcardRotation = 0.0
    @Published var contentRotation = 0.0
}
