//
//  WordSelectionView.swift
//  MyCEFR
//
//  Created by Лаборатория on 12.11.2023.
//

import SwiftUI

struct WordSelectionView: View {

    @EnvironmentObject var coordinator: Coordinator
    @StateObject var viewModel: WordSelectionViewModel

    var body: some View {
        VStack {
            Text("\(viewModel.words.count)")
        }
        .modifier(BackgroundElement(isProfile: true,
                                    headingText: viewModel.fullNameLevel(),
                                    colorBack: Color(uiColor: coordinator.levelBackColor(level: viewModel.level)),
                                    completion: { coordinator.goBackHome() }))
        .environmentObject(coordinator)
    }
}

#Preview {
    WordSelectionView(viewModel: WordSelectionViewModel(words: [Word(id: "1",
                                                                    groupID: "1",
                                                                     groupName: "group",
                                                                     word: "name",
                                                                     translation: "имя",
                                                                     transcription: "[naim]",
                                                                     partOfSpeechID: "noun")],
                                                        level: Level(id: "1",
                                                                     name: "А1",
                                                                     fullName: "Elementary")))
    .environmentObject(Coordinator(isWorker: true))
}
