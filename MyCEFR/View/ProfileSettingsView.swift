//
//  ProfileSettingsView.swift
//  MyCEFR
//
//  Created by Лаборатория on 31.05.2023.
//

import SwiftUI

struct ProfileSettingsView: View {

    @StateObject var viewModel: ProfileSettingsViewModel

    var body: some View {
        VStack(spacing: 100) {
            Text(viewModel.email)
                .modifier(TextElement(size: 40, foregroundColor: .black))
            ButtonView(viewModel: viewModel.buttonExitVM,
                       color: Color("RedTopicColor"),
                       width: 80)
        }
        .fullScreenCover(isPresented: $viewModel.showAuthorizationScreen) {
            AuthorizationView()
        }

    }

}

struct ProfileSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSettingsView(viewModel: ProfileSettingsViewModel())
    }
}