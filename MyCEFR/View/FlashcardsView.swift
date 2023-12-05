//
//  FlashcardsView.swift
//  MyCEFR
//
//  Created by Лаборатория on 01.12.2023.
//

import SwiftUI
import ConfettiSwiftUI

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
            if viewModel.isFinishedRound {
                VStack {
                    VStack(spacing: 100)  {
                        HStack {
                            goodJobText()
                            fireworkButton()
                        }
                        successfulWordsInfo()
                    }
                    .padding()
                    Spacer()
                    finishedRoundButtons()
                }
                .padding(.top, 85)
                .confettiCannon(counter: $viewModel.fireworkCounter, repetitions: 20, repetitionInterval: 0.1)
            } else {
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
            }
        }
        .modifier(BackgroundElement(isProfile: true,
                                    isBottomPading: false,
                                    headingText: viewModel.fullNameLevel(),
                                    colorBack: Color(uiColor: coordinator.levelBackColor(level: viewModel.level)),
                                    completion: {
            coordinator.isShowTabBar = true
            coordinator.goBackHome()
        }))
        .onAppear {
            coordinator.isShowTabBar = false
            viewModel.setupActiveWord(selectedWordsID: coordinator.selectedWordsID)
            viewModel.flashcardVM.setupCompletionBackButten {
                backCardButtonAnimation()
            }
        }
        .animation(.easeInOut, value: animSquare)
        .animation(.easeInOut, value: viewModel.isFinishedRound)
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
                .cornerRadius(sWECornerRadius(isLeft: isLeft),
                              corners: isLeft ? [.topRight, .bottomRight] : [.topLeft, .bottomLeft])
                .frame(width: sWEFrameWidth(isLeft: isLeft),
                       height: sWEFrameHeight(isLeft: isLeft))
                .foregroundStyle(color.opacity(0.42))
            Text(sWEText(text: text, isLeft: isLeft))
                .foregroundStyle(isLeft ? .red : .green)
                .font(Font.custom("Spectral", size: sWEFontSize(isLeft: isLeft)))
        }
        .frame(height: 100)
        .overlay(
            RoundedRectangle(cornerRadius: sWECornerRadius(isLeft: isLeft))
                .stroke(color, lineWidth: 2)
                .frame(width: sWEFrameWidth(isLeft: isLeft) + 20,
                       height: sWEFrameHeight(isLeft: isLeft))
                .padding(.trailing, isLeft ? 20 : 0)
                .padding(.leading, isLeft ? 0 : 20)
        )
        .animation(.easeInOut, value: draggetOffsetCard)
    }

    func sWEFrameWidth(isLeft: Bool) -> Double {
        if draggetOffsetCard.width < 0 && isLeft {
            return 80
        } else if draggetOffsetCard.width > 0 && !isLeft {
            return 80
        } else {
            return 60
        }
    }

    func sWEFrameHeight(isLeft: Bool) -> Double {
        if draggetOffsetCard.width < 0 && isLeft {
            return 60
        } else if draggetOffsetCard.width > 0 && !isLeft {
            return 60
        } else {
            return 40
        }
    }

    func sWECornerRadius(isLeft: Bool) -> Double {
        if draggetOffsetCard.width < 0 && isLeft {
            return 30
        } else if draggetOffsetCard.width > 0 && !isLeft {
            return 30
        } else {
            return 20
        }
    }

    func sWEText(text: String, isLeft: Bool) -> String {
        if draggetOffsetCard.width < 0 && isLeft {
            return "+ 1"
        } else if draggetOffsetCard.width > 0 && !isLeft {
            return "+ 1"
        } else {
            return text
        }
    }

    func sWEFontSize(isLeft: Bool) -> Double {
        if draggetOffsetCard.width < 0 && isLeft {
            return 32
        } else if draggetOffsetCard.width > 0 && !isLeft {
            return 32
        } else {
            return 24
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

    private func backCardButtonAnimation() {
        withAnimation(.linear(duration: 0.7)) {
            cardPosition = 400
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500))  {
            viewModel.backCardButtonAction()
            cardPosition = -400
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
                .frame(width: 30, height: 30)
        }
    }

    private func fireworkButton() -> some View {
        Button {
            viewModel.fireworkCounter += 1
        } label: {
            Image("FireworkImage")
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60)
        }
    }

    private func goodJobText() -> some View {
        Text("good job!".localized)
            .font(Font.custom("Spectral", size: 20)
                .weight(.semibold))
            .foregroundStyle(.black)
    }

    private func successfulWordsInfo() -> some View {
        VStack {
            successfulWordsInfoText(text: "know".localized + ": \(viewModel.successfulWordsID.count)", isSuccessful: true)
            successfulWordsInfoText(text: "pending".localized + ": \(viewModel.unsuccessfulWordsID.count)", isSuccessful: false)
        }
    }

    private func successfulWordsInfoText(text: String, isSuccessful: Bool) -> some View {
        Text(text)
            .font(Font.custom("Spectral", size: 24))
            .padding()
            .frame(maxWidth: .infinity)
            .background(isSuccessful ? Color("GreenWordCardsColor").opacity(0.42) : Color("RedWordCardsColor").opacity(0.42))
            .foregroundStyle(isSuccessful ? .green : .red)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(isSuccessful ? Color("GreenWordCardsColor") : Color("RedWordCardsColor"), lineWidth: 2))
    }

    private func finishedRoundButton(text: String, isActive: Bool, completion: (()->())?) -> some View {
        VStack {
            if isActive {
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
            } else {
                Text(text)
                    .font(Font.custom("Spectral", size: 17)
                        .weight(.semibold))
                    .foregroundStyle(.white)
                    .frame(width: 300, height: 40)
                    .background(Color("MainBlueColor").opacity(0.3))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
    }

    private func finishedRoundButtons() -> some View {
        VStack(spacing: 10) {
            finishedRoundButton(text: "continueThePending".localized,
                                isActive: !viewModel.unsuccessfulWordsID.isEmpty) {
                viewModel.continueThePendingButton()
            }
            finishedRoundButton(text: "practiceSpelling".localized,
                                isActive: false, completion: nil)
            finishedRoundButton(text: "restartСards".localized,
                                isActive: true) {
                viewModel.reload()
                viewModel.isFinishedRound.toggle()
            }
        }
        .padding()
    }
}
