//
//  LevelView.swift
//  MyCEFR
//
//  Created by Лаборатория on 09.11.2023.
//

import SwiftUI

struct LevelView: View {

    @EnvironmentObject var coordinator: Coordinator
    @StateObject var viewModel: LevelViewModel

    var body: some View {
//        VStack {
            VStack(spacing: 20) {
                Button {
                    coordinator.goWordGroup()
                } label: {
                    buttonView(label: "vocabulary".localized)
                }
                Button {

                } label: {
                    buttonView(label: "grammar".localized)
                }
                Button {

                } label: {
                    buttonView(label: "test".localized)
                }
            }
            .padding()
//            Spacer()
//        }
        .padding(.top, 85)
        .modifier(BackgroundElement(isProfile: true,
                                    isFirstScreen: true,
                                    headingText: viewModel.fullNameLevel(),
                                    colorBack: Color(uiColor: coordinator.levelBackColor(level: viewModel.level))))
        .environmentObject(coordinator)
    }
}

#Preview {
    LevelView(viewModel: LevelViewModel(level: Level(id: "1",
                                                     name: "А1",
                                                     fullName: "Elementary")))
        .environmentObject(Coordinator(isWorker: true))
}

extension LevelView {

    private func buttonView(label: String) -> some View {
        HStack {
            Text(label)
                .font(.custom("Spectral-Regular", size: 24))
                .foregroundStyle(.white)
            Spacer()
            Image(systemName: "arrow.forward.circle")
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40)
                .foregroundColor(.white)
//                .shadow(color: .black.opacity(0.5), radius: 2, x: 0, y: 2)
        }
        .padding()
        .background(Color("MainBlueColor"))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.5), radius: 2, x: 0, y: 2)
    }
}
