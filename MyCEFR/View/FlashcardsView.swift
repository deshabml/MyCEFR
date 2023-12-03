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
    @State var animSquare = false
    @State var cardPosition: CGFloat = 0

    var body: some View {
        VStack {
            ZStack {
                Text(viewModel.progressInfoText())
                    .font(Font.custom("Spectral", size: 20)
                        .weight(.semibold))
                    .foregroundStyle(.white)
                HStack {
                    Spacer()
                    Button {
//                        viewModel.reload()
                        animationReload()
                    } label: {
                        Text(viewModel.isEnToRus ? "eng → ru" : "ru → eng")
                            .font(Font.custom("Spectral", size: 20)
                                .weight(.semibold))
                            .foregroundStyle(.white)
                    }
                    .padding(.horizontal)
                }
            }
            VStack {
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                    .background(.yellow)
                FlashcardView(viewModel: viewModel.flashcardVM)
                    .rotationEffect(.degrees(animSquare ? 720 : 0))
                    .offset(x: cardPosition)
                shuffleButton()
                successfulWordCounter()
            }
        }
        .padding(.top, 50)
        .modifier(BackgroundElement(isProfile: true,
                                    headingText: viewModel.fullNameLevel(),
                                    colorBack: Color(uiColor: coordinator.levelBackColor(level: viewModel.level)),
                                    completion: { coordinator.goBackHome() }))
        .onAppear {
            viewModel.setupActiveWord(selectedWordsID: coordinator.selectedWordsID)
        }
        .animation(.easeInOut, value: animSquare)
    }
}

#Preview {
    FlashcardsView(viewModel: FlashcardsViewModel(words: [],
                                                  level: Level(id: "1",
                                                               name: "level",
                                                               fullName: "FulLevel")))
        .environmentObject(Coordinator(isWorker: true))
}

extension FlashcardsView {

    private func shuffleButton() -> some View {
        Button {
            animSquare.toggle()
            viewModel.shuffle()
        } label: {
            VStack {
                Image("ShuffleImage")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 20, height: 20)
                Text("shuffle".localized)
                    .font(Font.custom("Spectral", size: 13)
                        .weight(.medium))
                    .foregroundStyle(.black)
            }
        }
    }

    private func successfulWordCounter() -> some View {
        HStack {
            ZStack {
                Rectangle()
                    .cornerRadius(20, corners: [.topRight, .bottomRight])
                    .frame(width: 60, height: 40)
                    .foregroundStyle(Color("RedWordCardsColor").opacity(0.42))
                Text("\(viewModel.unsuccessfulWordsID.count)")
                    .foregroundStyle(.red)
            }
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color("RedWordCardsColor"), lineWidth: 2)
                    .frame(width: 80, height: 40)
                    .padding(.trailing, 20)
            )
            Spacer()
            ZStack {
                Rectangle()
                    .cornerRadius(20, corners: [.topLeft, .bottomLeft])
                    .frame(width: 60, height: 40)
                    .foregroundStyle(Color("GreenWordCardsColor").opacity(0.34))
                Text("\(viewModel.successfulWordsID.count)")
                    .foregroundStyle(.green)
            }
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color("GreenWordCardsColor"), lineWidth: 2)
                    .frame(width: 80, height: 40)
                    .padding(.leading, 20)
            )
        }
    }

    private func animationReload() {
        withAnimation(.linear(duration: 0.7)) {
            cardPosition = -400
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500))  {
            viewModel.isEnToRusToggle()
            cardPosition = 400
            withAnimation(.linear(duration: 0.7)) {
                cardPosition = 0
            }
        }
    }
}
