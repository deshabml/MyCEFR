//
//  ShowScreenView.swift
//  MyCEFR
//
//  Created by Лаборатория on 01.12.2023.
//

import SwiftUI

struct ShowScreenView<Content: View>: View {

    @EnvironmentObject var coordinator: Coordinator
    @StateObject var viewModel: ShowScreenViewModel
    var screen: Content

    var body: some View {
        ZStack {
            if viewModel.isShow {
                Rectangle()
                    .ignoresSafeArea()
                    .opacity(0.6)
                    .onTapGesture {
                        viewModel.isShow.toggle()
                    }
                screen
                    .environmentObject(coordinator)
                    .modifier(ShowScreenSettingsElement())
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .animation(.easeInOut, value: viewModel.isShow)
    }
}

#Preview {
    ShowScreenView(viewModel: ShowScreenViewModel(), screen: ChoosingStudyMethodView())
        .environmentObject(Coordinator(isWorker: true))
}
