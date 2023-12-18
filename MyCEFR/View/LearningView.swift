//
//  LearningView.swift
//  MyCEFR
//
//  Created by Лаборатория on 06.12.2023.
//

import SwiftUI
import ConfettiSwiftUI

struct LearningView: View {

    @EnvironmentObject var coordinator: Coordinator
    @StateObject var viewModel: LearningViewModel

    var body: some View {
        VStack {
            if viewModel.isFinishedRound {
                VStack(spacing: 0) {
                    finalInformationBar
                    if !viewModel.isSuccessfully {
                        finalStatistics
                    }
                    ZStack {
                        if viewModel.isSuccessfully {
                            successfullyRound
                        } else {
                            finalWordsList
                        }
                        finishedRoundButton(text: "restart".localized) {
                            viewModel.restartRound()

                        }
                    }
                    .padding(.top, 2)
                }
                .padding(.top, 50)
            } else {
                VStack {
                    informationBar
                    Spacer()
                    VStack(spacing: 200) {
                        denmarkZone
                        responseZone
                    }
                    .padding(.horizontal)
                    Spacer()
                }
                .padding(.top, 50)
            }
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
        .onAppear {
            coordinator.isShowTabBar = false
            viewModel.setupActiveWord(selectedWordsID: coordinator.selectedWordsID)
            viewModel.setupCompletion { successfulWordsID in
                coordinator.addSuccessfullyLearnedWordsID(successfulWordsID: successfulWordsID)
            }
        }
        .animation(.easeInOut(duration: 0.5), value: viewModel.activeWordIndex)
        .animation(.easeInOut(duration: 0.7), value: viewModel.showSuccessfulWordsAnimation)
        .animation(.easeInOut(duration: 0.7), value: viewModel.showUnsuccessfulWordsAnimation)
        .animation(.linear(duration: 0.3), value: viewModel.showTextField)
        .animation(.easeInOut(duration: 0.5), value: viewModel.isFinishedRound)
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

    private var informationBar: some View {
        ZStack {
            Text(viewModel.progressInfoText())
                .font(Font.custom("Spectral", size: 20)
                    .weight(.semibold))
                .foregroundStyle(.white)
            HStack {
                Spacer()
                Button {
                    viewModel.isEnToRusToggle()
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

    private var finalInformationBar: some View {
        Text("results".localized)
            .font(Font.custom("Spectral", size: 20)
                .weight(.semibold))
            .foregroundStyle(.white)
    }

    private var finalWordsList: some View {
        ScrollView(.vertical) {
            ForEach( 0 ..< viewModel.activeWords.count, id: \.self) { index in
                finalWordCell(index: index)
            }
            .padding(.top, 8)
            .padding(.bottom, 50)
        }
    }

    private func finalWordCell(index: Int) -> some View {
        HStack {
            VStack {
                HStack {
                    finalWordCellText(text: viewModel.activeWords[index].word,
                                      isCorrect: viewModel.isCoorectWord(index: index))
                    Spacer()
                }
                HStack {
                    finalWordCellText(text: viewModel.activeWords[index].translation,
                                      isCorrect: viewModel.isCoorectWord(index: index))
                    Spacer()
                }
            }
            .padding(.leading, 20)
            Spacer()
            finalStatisticsText(text: viewModel.isCoorectWord(index: index) ? "correct".localized : "skipped".localized,
                                isCorrect: viewModel.isCoorectWord(index: index))

        }
        .padding(.vertical, 8)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black, radius: 2)
        .padding(.horizontal)
        .padding(.vertical, 8)
    }


    private var finalStatistics: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                finalStatisticsText(text: "correct".localized,
                                    isCorrect: true)
                Divider()
                    .frame(width: 1)
                    .background(.black)
                finalStatisticsText(text: "skipped".localized)
            }
            .frame(height: 30)
            Divider()
                .frame(height: 1)
                .background(.black)
            HStack(spacing: 0) {
                finalStatisticsText(text: "\(viewModel.successfulWordsID.count)")
                finalStatisticsText(text: "\(viewModel.unsuccessfulWordsID.count)")
            }
            .frame(height: 30)
        }
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black, radius: 2)
        .padding(.top)
        .padding(.horizontal)
    }

    private func finalStatisticsText(text: String, isCorrect: Bool = false) -> some View {
        Text(text)
            .font(Font.custom("Spectral", size: 20))
            .foregroundStyle(isCorrect ? .green : .black)
            .frame(width:  (UIScreen.main.bounds.size.width - 32) / 2)
    }

    private func finalWordCellText(text: String, isCorrect: Bool = false) -> some View {
        Text(text)
            .font(Font.custom("Spectral", size: 20))
            .foregroundStyle(isCorrect ? .green : .black)
    }

    private func finishedRoundButton(text: String, completion: (()->())?) -> some View {
        VStack {
            Spacer()
            Button {
                completion?()
            } label: {
                Text(text)
                    .font(Font.custom("Spectral", size: 17)
                        .weight(.semibold))
                    .foregroundStyle(.white)
            }
            .frame(width: 300, height: 40)
            .background(Color("MainBlueColor"))
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }

    private var denmarkZone: some View {
        VStack(spacing: 0) {
            HStack {
                Text(viewModel.activeWordText())
                    .font(Font.custom("Spectral", size: 34))
                Spacer()
                if viewModel.isEnToRus {
                    soundButton
                }
            }
            Divider()
                .frame(height: 2)
                .background(.black)
        }
    }

    private var responseZone: some View {
        VStack(spacing: 0) {
            HStack {
                if viewModel.showTextField {
                    TextField("", text: $viewModel.activeUserResponseText)
                        .font(Font.custom("Spectral", size: 24))
                        .keyboardType(.namePhonePad)
                        .disableAutocorrection(true)
                        .textFieldStyle(.plain)
                }
                Spacer()
                skipButton
            }
            Divider()
                .frame(height: 4)
                .background(dividerColor())
        }
    }

    private var skipButton: some View {
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
    
    private var successfullyText: some View {
        Text("successfullyTest".localized)
            .font(Font.custom("Spectral", size: 20)
                .weight(.semibold))
            .foregroundStyle(.black)
    }

    private var fireworkImage: some View {
        Image("FireworkImage")
            .resizable()
            .scaledToFill()
            .frame(width: 60, height: 60)
    }

    private var successfullyRound: some View {
        VStack {
            HStack {
                successfullyText
                fireworkImage
            }
            successfullyInfo
                .padding(.top, 70)
            Spacer()
        }
        .padding(.top, 60)
        .confettiCannon(counter: $viewModel.fireworkCounter, repetitions: 20, repetitionInterval: 0.1)
    }

    private var successfullyInfo: some View {
        HStack {
            Text(viewModel.fullNameLevel())
                .font(Font.custom("Spectral", size: 20)
                    .weight(.semibold))
                .foregroundStyle(.green)
                .padding(.horizontal)
            Spacer()
            if let calculatingProgress = coordinator.calculatingProgressGroup(), calculatingProgress == 1 {
                Image(systemName: "checkmark")
                    .frame(width: 50, height: 50)
                    .foregroundStyle(.green)
                    .padding(.horizontal)
            }
        }
        .frame(height: 80)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black, radius: 2)
        .padding()
        .overlay {
            progressBar
        }
    }

    private var progressBar: some View {
        VStack {
            Spacer()
            if let calculatingProgress = coordinator.calculatingProgressGroup(), calculatingProgress < 1 {
                ProgressView(value: calculatingProgress)
                    .progressViewStyle(.linear)
                    .frame(height: 8)
                    .tint(.green)
                    .background(Color("ProgressBackLevelColor"))
                    .cornerRadius(4)
                    .padding(.horizontal)
            }
        }
        .padding(.bottom, 18)
        .padding(.horizontal, 40)
    }
}
