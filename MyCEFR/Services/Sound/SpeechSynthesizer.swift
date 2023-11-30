//
//  SpeechSynthesizer.swift
//  MyCEFR
//
//  Created by Лаборатория on 12.11.2023.
//

//import AVFoundation
//
//class Speaker: NSObject, AVSpeechSynthesizerDelegate {
//    
//    let synthesizer = AVSpeechSynthesizer()
//
//    override init() {
//        super.init()
//        synthesizer.delegate = self
//    }
//
//    func speak(msg: String) {
//        let utterance = AVSpeechUtterance(string: msg)
//
//        utterance.rate = 0.57
//        utterance.pitchMultiplier = 0.8
//        utterance.postUtteranceDelay = 0.2
//        utterance.volume = 0.8
//
//        let voice = AVSpeechSynthesisVoice(language: "en-US")
//
//        utterance.voice = voice
//        synthesizer.speak(utterance)
//    }
//}

//class SpeechSynthesizer: NSObject {
//
//    private var speechSynthesizer = AVSpeechSynthesizer()
//
//    static let shared = SpeechSynthesizer()
//
//
//    private override init() {
//        super.init()
//        self.speechSynthesizer.delegate = self
//    }
//
//    func speak(text: String) {
//        let utterance = AVSpeechUtterance(string: text)
//        speechSynthesizer.speak(utterance)
//    }
//}
//
//extension SpeechSynthesizer: AVSpeechSynthesizerDelegate {
//
//    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
//        print("started")
//    }
//
//    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didPause utterance: AVSpeechUtterance) {
//        print("paused")
//    }
//
//    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didContinue utterance: AVSpeechUtterance) {}
//
//    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {}
//
//    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {}
//
//    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
//        print("finished")
//    }
//}
