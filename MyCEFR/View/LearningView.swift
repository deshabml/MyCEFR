//
//  LearningView.swift
//  MyCEFR
//
//  Created by Лаборатория on 06.12.2023.
//

import SwiftUI

struct LearningView: View {

    @EnvironmentObject var coordinator: Coordinator
    @StateObject var viewModel: LearningViewModel

    var body: some View {
        VStack {
            informationBar()
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            Spacer()
        }
        .padding(.top, 50)
        .onAppear {
            coordinator.isShowTabBar = false
            viewModel.setupActiveWord(selectedWordsID: coordinator.selectedWordsID)
        }
        .modifier(BackgroundElement(isProfile: true,
                                    isBottomPading: false,
                                    isActionScreen: true,
                                    headingText: viewModel.fullNameLevel(),
                                    colorBack: Color(uiColor: coordinator.levelBackColor(level: viewModel.level)),
                                    completion: {
            coordinator.isShowTabBar = true
            coordinator.goBackHome()
        }))
    }
}

#Preview {
    LearningView(viewModel: LearningViewModel(words: [],
                                              level: Level(id: "1",
                                                           name: "level",
                                                           fullName: "FulLevel")))
    .environmentObject(Coordinator(isWorker: true))
}

extension LearningView {

    private func informationBar() -> some View {
        ZStack {
            Text(viewModel.progressInfoText())
                .font(Font.custom("Spectral", size: 20)
                    .weight(.semibold))
                .foregroundStyle(.white)
            HStack {
                Spacer()
                Button {
//                    animationReload()
                } label: {
                    Text(viewModel.isEnToRus ? "eng → ru" : "ru → eng")
                        .font(Font.custom("Spectral", size: 20)
                            .weight(.semibold))
                        .foregroundStyle(.white)
                }
                .padding(.horizontal)
            }
        }
    }
}
