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
            .padding(.top, 85)

        .modifier(BackgroundElement(isProfile: true,
                                    headingText: viewModel.fullNameLevel(),
                                    colorBack: Color(uiColor: coordinator.levelBackColor(level: viewModel.level)),
                                    completion: { coordinator.goBackHome() }))
        .environmentObject(coordinator)
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
        Button {
            
        } label: {
            HStack(spacing: 10) {
                Image("WordGroupImage")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                Text(wordGroup.group.name)
                    .font(.custom("Spectral-Regular", size: 16))
                Spacer()
                VStack(alignment: .center) {
                    Text("\(wordGroup.count)")
                        .font(.custom("Spectral-Regular", size: 20))
                }
                .frame(width: 20)
            }
            .padding()
            .foregroundStyle(.black)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 17))
            .shadow(color: .gray.opacity(0.5), radius: 2)
            .padding(.horizontal)
        }
    }
}
