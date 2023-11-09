//
//  Word.swift
//  MyCEFR
//
//  Created by Лаборатория on 28.08.2023.
//

import Foundation

struct Word: Identifiable {

    var id: String = UUID().uuidString
    var groupID: String
    var groupName: String
    var word: String
    var translation: String
    var transcription: String
    var partOfSpeechID: String

}

extension Word {

    var representation: [String: Any] {
        var dict: [String: Any] = [:]
        dict["id"] = self.id
        dict["groupID"] = self.groupID
        dict["groupName"] = self.groupName
        dict["word"] = self.word
        dict["translation"] = self.translation
        dict["transcription"] = self.transcription
        dict["partOfSpeechID"] = self.partOfSpeechID
        return dict
    }

    init?(data: [String: Any]) {
        guard let id: String = data["id"] as? String,
              let groupID: String = data["groupID"] as? String,
              let groupName: String = data["groupName"] as? String,
              let word: String = data["word"] as? String,
              let translation: String = data["translation"] as? String,
              let transcription: String = data["transcription"] as? String,
              let partOfSpeechID: String = data["partOfSpeechID"] as? String else { return nil }
        self.id = id
        self.groupID = groupID
        self.groupName = groupName
        self.word = word
        self.translation = translation
        self.transcription = transcription
        self.partOfSpeechID = partOfSpeechID
    }

}

struct JSONWord: Codable {

    var word: String
    var translation: String
    var transcription: String
    var partOfSpeech: String

}
