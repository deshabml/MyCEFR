//
//  ShowScreen.swift
//  MyCEFR
//
//  Created by Лаборатория on 08.06.2023.
//

import SwiftUI

struct ShowScreenEPView<Content: View>: View {

    @EnvironmentObject var coordinator: Coordinator
    @StateObject var viewModel: ShowScreenEPViewModel
    var screen: Content
    
    var body: some View {
        ZStack {
            if viewModel.isShow {
                Rectangle()
                    .ignoresSafeArea()
                    .opacity(0.6)
                screen
                    .environmentObject(coordinator)
                    .modifier(ShowScreenSettingsElement(imageName: viewModel.imageName))
                
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .animation(.easeInOut, value: viewModel.isShow)
    }
    
}
