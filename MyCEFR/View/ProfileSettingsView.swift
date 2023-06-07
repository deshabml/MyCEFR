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
            HStack() {
                VStack(alignment: .leading, spacing: 10) {
                    Text(viewModel.userProfile.name)
                        .modifier(TextElement(size: 25, foregroundColor: .black))
                    Text(viewModel.userProfile.eMail)
                        .modifier(TextElement(size: 18, foregroundColor: .gray))
                    Text("\(viewModel.userProfile.phone)")
                        .modifier(TextElement(size: 18, foregroundColor: .gray))
                }
                Spacer()
                VStack {
                    if let image = viewModel.image {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } else {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .foregroundColor(.white)
                            .background(Color("MainBlueColor"))
                    }
                }
                .frame(width: 100, height: 100)
                .cornerRadius(50)
                .addBorder(.white,
                           width: 6,
                           cornerRadius: 50)
                .addBorder(Color("MainBlueColor"),
                           width: 2,
                           cornerRadius: 50)
            }
            .padding(.top, 110)
//            .padding(.horizontal, 200)
            Spacer()
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
