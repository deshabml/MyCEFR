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
                VStack(spacing: 0) {
                    HStack {
                        if viewModel.showTextField {
                            TextField("", text: $viewModel.activeUserResponseText)
                                .font(Font.custom("Spectral", size: 24))
                        }
                        Spacer()
                        Button {
                            viewModel.showUnsuccessfulWordsAnimation = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                                viewModel.dontKnowButtonAction()
                                viewModel.showUnsuccessfulWordsAnimation = false
                            }
                        } label: {
                            Text(viewModel.activeUserResponseText.isEmpty ? "dontKnow".localized : "skip".localized)
                                .font(Font.custom("Spectral", size: 18))
                                .foregroundStyle(Color("MainBlueColor"))
                        }
                    }
                    Divider()
                        .frame(height: 4)
                        .background(dividerColor())
                }
            }
            .padding(.horizontal)
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
        .animation(.easeInOut(duration: 0.5), value: viewModel.activeWordIndex)
        .animation(.easeInOut(duration: 0.7), value: viewModel.showSuccessfulWordsAnimation)
        .animation(.easeInOut(duration: 0.7), value: viewModel.showUnsuccessfulWordsAnimation)
        .animation(.linear(duration: 0.3), value: viewModel.showTextField)
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

    private func dividerColor() -> Color {
        if viewModel.showUnsuccessfulWordsAnimation {
            return .red
        } else if viewModel.showSuccessfulWordsAnimation {
            return .green
        } else {
            return .black
        }
    }
}
