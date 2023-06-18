//
//  ShowScreen.swift
//  MyCEFR
//
//  Created by Лаборатория on 08.06.2023.
//

import SwiftUI

struct ShowScreenEPView<Content: View>: View {

    @StateObject var viewModel: ShowScreenEPViewModel
    var screen: Content

    var body: some View {
        if viewModel.isShow {
            Rectangle()
                .ignoresSafeArea()
                .opacity(0.6)
            screen
                .modifier(ShowScreenSettingsElement(imageName: viewModel.imageName))
        }
    }

}
