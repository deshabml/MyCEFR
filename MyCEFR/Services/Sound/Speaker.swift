//
//  SpeechSynthesizer.swift
//  MyCEFR
//
//  Created by Лаборатория on 12.11.2023.
//

import AVFoundation

class Speaker: NSObject, AVSpeechSynthesizerDelegate {
    
    let synthesizer = AVSpeechSynthesizer()

    static let shared = Speaker()

    private override init() {
        super.init()
        synthesizer.delegate = self
    }

    func speak(msg: String) {
        let utterance = AVSpeechUtterance(string: msg)
        utterance.rate = 0.4
        utterance.pitchMultiplier = 0.8
        utterance.postUtteranceDelay = 0.4
        utterance.volume = 0.8
        let voice = AVSpeechSynthesisVoice(language: "en-GB")
        utterance.voice = voice
        synthesizer.speak(utterance)
    }
}
