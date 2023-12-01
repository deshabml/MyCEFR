//
//  FlashcardsView.swift
//  MyCEFR
//
//  Created by Лаборатория on 01.12.2023.
//

import SwiftUI

struct FlashcardsView: View {

    @EnvironmentObject var coordinator: Coordinator
    @StateObject var viewModel: FlashcardsViewModel

    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
        .modifier(BackgroundElement(isProfile: true,
                                    headingText: viewModel.fullNameLevel(),
                                    colorBack: Color(uiColor: coordinator.levelBackColor(level: viewModel.level)),
                                    completion: { coordinator.goBackHome() }))
    }
}

#Preview {
    FlashcardsView(viewModel: FlashcardsViewModel(words: [],
                                                  level: Level(id: "1",
                                                               name: "level",
                                                               fullName: "FulLevel")))
        .environmentObject(Coordinator(isWorker: true))
}
