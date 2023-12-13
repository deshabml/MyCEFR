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
            Spacer()
            VStack(spacing: 200) {
                VStack(spacing: 0) {
                    HStack {
                        Text(viewModel.activeWordText())
                            .font(Font.custom("Spectral", size: 34))
                        Spacer()
                        soundButton
                    }
                    Divider()
                        .frame(height: 2)
                        .background(.black)
                }
                VStack {
                    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                    Divider()
                        .frame(height: 4)
                        .background(.black)
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 200)
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

    private var soundButton: some View {
        Button {
            viewModel.soundButtonAction()
        } label: {
            Image("SoundSecondImage")
                .resizable()
                .scaledToFill()
                .foregroundStyle(.black)
                .frame(width: 30, height: 30)
        }
    }
}
