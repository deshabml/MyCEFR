//
//  Word.swift
//  MyCEFR
//
//  Created by Лаборатория on 28.08.2023.
//

import Foundation

struct Word: Identifiable {

    var id: String = UUID().uuidString
    var word: String
    var translation: String
    var transcription: String
    var partOfSpeech: PartOfSpeech

}
