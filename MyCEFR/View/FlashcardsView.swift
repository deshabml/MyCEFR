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
    @State var draggetOffsetCard = CGSize.zero
    @State var opticalCard: Double = 1
    @State var rotationSwipeCard: Double = 0

    var body: some View {
        VStack {
            informationBar()
            VStack {
                HStack {
                    Spacer()
                    selectedWordButton()
                        .padding(.horizontal)
                }
                card()
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
        .toolbar(.hidden, for: .tabBar)
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
            successfulWordElement(color: Color("RedWordCardsColor"),
                                  text: "\(viewModel.unsuccessfulWordsID.count)",
                                  isLeft: true)
            Spacer()
            successfulWordElement(color: Color("GreenWordCardsColor"),
                                  text: "\(viewModel.successfulWordsID.count)",
                                  isLeft: false)
        }
    }

    private func successfulWordElement(color: Color, text: String, isLeft: Bool) -> some View {
        ZStack {
            Rectangle()
                .cornerRadius(20, corners: isLeft ? [.topRight, .bottomRight] : [.topLeft, .bottomLeft])
                .frame(width: 60, height: 40)
                .foregroundStyle(color.opacity(0.42))
            Text("\(text)")
                .foregroundStyle(isLeft ? .red : .green)
        }
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(color, lineWidth: 2)
                .frame(width: 80, height: 40)
                .padding(.trailing, isLeft ? 20 : 0)
                .padding(.leading, isLeft ? 0 : 20)
        )
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

    private func card() -> some View {
        FlashcardView(viewModel: viewModel.flashcardVM)
            .rotationEffect(.degrees(animSquare ? 720 : 0))
            .rotationEffect(.degrees(rotationSwipeCard))
            .offset(x: cardPosition)
            .offset(x: draggetOffsetCard.width)
            .gesture(DragGesture()
                .onChanged { value in
                    swipeRotationAnimation()
                    draggetOffsetCard = value.translation
                    if draggetOffsetCard.width < 0 {
                        viewModel.flashcardVM.style = .red
                    } else if draggetOffsetCard.width > 0 {
                        viewModel.flashcardVM.style = .green
                    }
                }
                .onEnded { value in
                    swipeRotationAnimation()
                    if value.translation.width < -100 {
                        viewModel.swipe(isLeft: true)
                        swipeAnimation(isLeft: true)
                    } else if value.translation.width > 100 {
                        viewModel.swipe(isLeft: false)
                        swipeAnimation(isLeft: false)
                    } else {
                        draggetOffsetCard = CGSize.zero
                        viewModel.flashcardVM.style = .standart
                        rotationSwipeCard = 0
                    }
                })
            .opacity(opticalCard)
    }

    private func informationBar() -> some View {
        ZStack {
            Text(viewModel.progressInfoText())
                .font(Font.custom("Spectral", size: 20)
                    .weight(.semibold))
                .foregroundStyle(.white)
            HStack {
                Spacer()
                Button {
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
    }

    func swipeAnimation(isLeft: Bool = true) {
        withAnimation(.linear(duration: 0.5)) {
            draggetOffsetCard = CGSize(width: isLeft ? -400 : 400, height: 0)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            opticalCard = 0
            rotationSwipeCard = 0
            draggetOffsetCard = CGSize.zero
            viewModel.flashcardVM.style = .standart
            withAnimation(.easeInOut(duration: 0.2)) {
                opticalCard = 1
            }
        }
    }

    func swipeRotationAnimation() {
        if draggetOffsetCard.width != 0 {
            withAnimation(.linear(duration: 0.1)) {
                rotationSwipeCard = draggetOffsetCard.width / 10
            }
        } else {
            withAnimation(.linear(duration: 0.1)) {
                rotationSwipeCard = 0
            }
        }
    }

    private func selectedWordButton() -> some View {
        Button {
            if viewModel.isSelectedWord(selectedWordsID: coordinator.selectedWordsID) {
                coordinator.deleteSelectedWordsID(viewModel.activeWords[viewModel.activeWordIndex].id)
            } else {
                coordinator.addSelectedWordsID(viewModel.activeWords[viewModel.activeWordIndex].id)
            }
        } label: {
            Image(viewModel.isSelectedWord(selectedWordsID: coordinator.selectedWordsID) ? "FlagActiveImage" : "FlagImage")
                .resizable()
                .scaledToFill()
                .frame(width: 20, height: 20)
        }
    }
}
