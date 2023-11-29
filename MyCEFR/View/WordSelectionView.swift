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
        ScrollView {
            VStack(spacing: 4) {
                ForEach(0 ..< viewModel.words.count, id: \.self) { index in
                    wordSelectionCell(index)
                    dividerWithCondition(index)
                }
            }
        }
        .padding(.top, 85)
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
                HStack(alignment: .center, spacing: 16) {
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
            soundButton {
                print("Run Sound")
            }
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
}
