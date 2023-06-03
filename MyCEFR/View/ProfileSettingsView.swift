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
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image("WhiteBackground")
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()
                .overlay(alignment: .bottom,content: {
                    Ellipse()
                        .foregroundColor(Color("MainBlueColor"))
                        .frame(width: 570, height: 492)
                        .padding(.vertical, 650)
                })
        )

    }

}

struct ProfileSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSettingsView(viewModel: ProfileSettingsViewModel(contentViewModel: ContentViewModel()))
    }
}
