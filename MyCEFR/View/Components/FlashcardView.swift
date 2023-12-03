//
//  FlashcardView.swift
//  MyCEFR
//
//  Created by Лаборатория on 01.12.2023.
//

import SwiftUI

struct FlashcardView: View {

    @StateObject var viewModel: FlashcardViewModel

    var body: some View {
        ZStack {
            if viewModel.flipped {
                back()
            } else {
                front()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.5), radius: 4, x: 0, y: 0)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.black, lineWidth: 2)
        )
        .padding()
        .padding(.horizontal, 40)
        .rotation3DEffect(.degrees(viewModel.contentRotation), axis: (x: 0, y: 1, z: 0))
        .rotation3DEffect(.degrees(viewModel.flashcardRotation), axis: (x: 0, y: 1, z: 0))
        .onTapGesture {
            flipFlashcard()
        }
    }
}

#Preview {
    FlashcardView(viewModel: FlashcardViewModel())
}

extension FlashcardView {

    func flipFlashcard() {
        let animationTime = 0.5
        withAnimation(Animation.linear(duration: animationTime)) {
            viewModel.flashcardRotation += 180
        }
        withAnimation(Animation.linear(duration: 0.001).delay(animationTime / 2)) {
            viewModel.contentRotation += 180
            viewModel.flipped.toggle()
        }
    }
}

extension FlashcardView {

    private func front() -> some View {
        VStack {
            mapControls()
            Spacer()
            HStack {
                Spacer()
                VStack(spacing: 6) {
                    VStack(spacing: 0) {
                        Text(viewModel.activeWord.word)
                            .font(Font.custom("Spectral", size: 32)
                                .weight(.semibold))
                        Text(viewModel.activeWord.partOfSpeechID)
                            .font(Font.custom("Spectral", size: 16)
                                .weight(.semibold))
                    }
                    Text(viewModel.activeWord.transcription)
                        .font(Font.custom("Spectral", size: 20)
                            .weight(.semibold))
                }
                Spacer()
            }
            Spacer()
        }
        .padding(.bottom, 25)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private func back() -> some View {
        VStack {
            mapControls()
            Spacer()
            HStack {
                Spacer()
                Text(viewModel.activeWord.translation)
                    .font(Font.custom("Spectral", size: 32)
                        .weight(.semibold))
                Spacer()
            }
            Spacer()
        }
        .padding(.bottom, 25)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private func mapControls() -> some View {
        HStack {
            Image(systemName: "airtag.radiowaves.forward.fill")
                .resizable()
                .scaledToFill()
                .foregroundStyle(.black)
                .frame(width: 25, height: 25)
            Spacer()
            if viewModel.isFirctWord {
                Image(systemName: "arrow.uturn.backward")
                    .resizable()
                    .scaledToFill()
                    .foregroundStyle(.black.opacity(0.5))
                    .frame(width: 25, height: 25)
            } else {
                Button {

                } label: {
                    Image(systemName: "arrow.uturn.backward")
                        .resizable()
                        .scaledToFill()
                        .foregroundStyle(.black)
                        .frame(width: 25, height: 25)
                }
            }
        }
        .padding()
    }
}
