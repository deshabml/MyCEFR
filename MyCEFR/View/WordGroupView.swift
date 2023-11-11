//
//  WordGroupView.swift
//  MyCEFR
//
//  Created by Лаборатория on 10.11.2023.
//

import SwiftUI

struct WordGroupView: View {

    @EnvironmentObject var coordinator: Coordinator
    @StateObject var viewModel: WordGroupViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(0 ..< viewModel.wordsGroup.count, id: \.self) { index in
                    wordCroupCell(wordGroup: viewModel.wordsGroup[index])
                }
            }
        }
    }
}

#Preview {
    WordGroupView(viewModel: WordGroupViewModel(level: Level(id: "1",
                                                             name: "А1",
                                                             fullName: "Elementary")))
    .environmentObject(Coordinator(isWorker: true))
}

extension WordGroupView {

    private func wordCroupCell(wordGroup: (group: Group, count: Int)) -> some View {
        HStack(spacing: 20) {
            Image(systemName: "text.book.closed")
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
            Text(wordGroup.group.name)
                .font(.custom("SFProText-Semibold", size: 15))
            Spacer()
            Text("\(wordGroup.count)")
                .font(.custom("SFProText-Semibold", size: 20))
        }
        .padding()
        .foregroundStyle(.black)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 17))
        .shadow(color: .gray.opacity(0.5), radius: 2)
        .padding(.horizontal)
    }
}
