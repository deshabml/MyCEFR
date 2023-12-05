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
        VStack(spacing: 0) {
            wordCounter()
            ZStack {
                ScrollView {
                    VStack(spacing: 8) {
                        ForEach(0 ..< viewModel.words.count, id: \.self) { index in
                            wordSelectionCell(index)
                            dividerWithCondition(index)
                        }
                    }
                }
                .padding(.top, 10)
                VStack {
                    Spacer()
                    continueButton()
                        .padding(.bottom, 70)
                }
            }
        }
        .overlay {
            ShowScreenView(viewModel: coordinator.showScreenViewModelCSM,
                           screen: ChoosingStudyMethodView())
            .environmentObject(coordinator)
        }
        .modifier(BackgroundElement(isProfile: true,
                                    isBottomPading: false,
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

extension WordSelectionView {

    private func soundButton(_ comletion: @escaping ()->()) -> some View {
        Button {
            comletion()
        } label: {
            Image("SoundImage")
                .renderingMode(.template)
                .resizable()
                .scaledToFill()
                .frame(width: 20, height: 20)
                .foregroundColor(Color("MainBlueColor"))
        }
    }

    private func wordSelectionCell(_ index: Int) -> some View {
        HStack(spacing: 4) {
            VStack(alignment: .center, content: {
                Text("\(index + 1).")
                    .font(Font.custom("Spectral-Regular", size: 20))
                    .foregroundStyle(.black)
            })
            .frame(width: 30)
            VStack(alignment: .leading, spacing: 2, content: {
                HStack(alignment: .center, spacing: 4) {
                    Text(viewModel.words[index].word)
                        .font(Font.custom("Spectral-Regular", size: 24))
                        .foregroundStyle(Color("MainBlueColor"))
                    Text("(\(viewModel.words[index].partOfSpeechID))")
                        .font(Font.custom("Spectral-Regular", size: 16))
                        .foregroundStyle(.black)
                }
                Text(viewModel.words[index].translation)
            })
            Spacer()
            HStack(spacing: 32) {
                soundButton {
                    print("Run Sound")
                }
                selectedWordButton(index: index)
            }
            .padding(.trailing, 16)
        }
        .padding(.horizontal, 4)
    }

    private func dividerWithCondition(_ index: Int) -> some View {
        VStack {
            if index != viewModel.words.count - 1 {
                Divider()
                    .background(.black)
            }
        }
    }

    private func selectedWordButton(index: Int) -> some View {
        Button {
            if viewModel.isSelectedWord(index: index, selectedWordsID: coordinator.selectedWordsID) {
                coordinator.deleteSelectedWordsID(viewModel.words[index].id)
            } else {
                coordinator.addSelectedWordsID(viewModel.words[index].id)
            }
            viewModel.isSelectedWordsTogle(selectedWordsID: coordinator.selectedWordsID)
        } label: {
            Image(viewModel.isSelectedWord(index: index, selectedWordsID: coordinator.selectedWordsID) ? "FlagActiveImage" : "FlagImage")
                .resizable()
                .scaledToFill()
                .frame(width: 20, height: 20)
        }
    }

    private func wordCounter() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                VStack {
                    if viewModel.isSelectedWords {
                        Text(viewModel.howManyWordsAreSelected(selectedWordsID: coordinator.selectedWordsID))
                            .font(Font.custom("Spectral-Regular", size: 18))
                            .foregroundStyle(Color("MainBlueColor"))
                    } else {
                        Text(viewModel.wordsInAGroup())
                            .font(Font.custom("Spectral-Regular", size: 18))
                            .foregroundStyle(Color("MainBlueColor"))
                    }
                }
                .padding(.vertical, 2)
                .padding(.horizontal, 6)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 6))
                Spacer()
                if viewModel.isSelectedWords {
                    Button {
                        coordinator.cancelTheSelectionWordsIDGroup(viewModel.words)
                        viewModel.isSelectedWordsTogle(selectedWordsID: coordinator.selectedWordsID)
                    } label: {
                        Text("cancelTheSelection".localized)
                            .font(Font.custom("Spectral", size: 20)
                                .weight(.bold))
                            .foregroundStyle(Color(.white))
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top, 40)
        }
        .onAppear {
            viewModel.isSelectedWordsTogle(selectedWordsID: coordinator.selectedWordsID)
        }
        .animation(.easeInOut, value: viewModel.isSelectedWords)
    }

    private func continueButton() -> some View {
        Button {
            coordinator.showScreenViewModelCSM.isShow.toggle()
        } label: {
            Text("continue".localized)
                .font(Font.custom("Spectral", size: 17)
                    .weight(.semibold))
                .foregroundStyle(.white)
        }
        .frame(width: 200, height: 40)
        .background(Color("MainBlueColor"))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(.bottom, 16)
    }
}
