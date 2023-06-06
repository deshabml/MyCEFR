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
            Spacer()
            Text(viewModel.email)
                .modifier(TextElement(size: 40, foregroundColor: .black))
            ButtonView(viewModel: viewModel.buttonExitVM,
                       color: (.white, Color("MainBlueColor")),
                       width: nil,
                       isBigButton: true)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .modifier(BackgroundElement(isProfile: true, headingText: "Settings"))
    }
    
}

struct ProfileSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSettingsView(viewModel: ProfileSettingsViewModel(contentViewModel: ContentViewModel()))
    }
}
