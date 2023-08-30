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
    var partOfSpeechID: String
    var groupID: String

}

extension Word {

    var representation: [String: Any] {
        var dict: [String: Any] = [:]
        dict["id"] = self.id
        dict["word"] = self.word
        dict["translation"] = self.translation
        dict["transcription"] = self.transcription
        dict["partOfSpeechID"] = self.partOfSpeechID
        dict["groupID"] = self.groupID
        return dict
    }

    init?(data: [String: Any]) {
        guard let id: String = data["id"] as? String,
              let word: String = data["word"] as? String,
              let translation: String = data["translation"] as? String,
              let transcription: String = data["transcription"] as? String,
              let partOfSpeechID: String = data["partOfSpeechID"] as? String,
              let groupID: String = data["groupID"] as? String else { return nil }
        self.id = id
        self.word = word
        self.translation = translation
        self.transcription = transcription
        self.partOfSpeechID = partOfSpeechID
        self.groupID = groupID
    }

}
