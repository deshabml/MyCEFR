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
                Text("Перед")
                Spacer()
            }
            Spacer()
        }
        .background(.yellow)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private func back() -> some View {
        VStack {
            mapControls()
            Spacer()
            HStack {
                Spacer()
                Text("Зад")
                Spacer()
            }
            Spacer()
        }
        .background(.brown)
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
            Button {
                flipFlashcard()
            } label: {
                Image(systemName: "arrow.uturn.backward")
                    .resizable()
                    .scaledToFill()
                    .foregroundStyle(.black)
                    .frame(width: 25, height: 25)
            }
        }
        .padding()
    }
}
