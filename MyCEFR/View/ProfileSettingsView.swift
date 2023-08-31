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
        VStack(alignment: .center,
               spacing: 12) {
            ZStack {
                VStack(spacing: 100) {
                    HStack() {
                        VStack(alignment: .leading, spacing: 10) {
                            Text(viewModel.editPVM.userProfile.name)
                                .modifier(TextElement(size: 25, foregroundColor: .black))
                            Text(viewModel.editPVM.userProfile.eMail)
                                .modifier(TextElement(size: 18, foregroundColor: .gray))
                            Text("\(viewModel.editPVM.userProfile.phone)")
                                .modifier(TextElement(size: 18, foregroundColor: .gray))
                        }
                        Spacer()
                        ImagePrifileView(viewModel: viewModel.imagePVM,
                                         size: 100)
                    }
                    .padding(.top, 110)
                    .onTapGesture {
                        viewModel.editUserData()
                    }
                    Spacer()
                    ButtonView(viewModel: viewModel.buttonExitVM,
                               color: (.white, Color("MainBlueColor")),
                               width: nil,
                               isBigButton: true)
                }
                .padding()
                ShowScreenEPView(viewModel: viewModel.editPVM.showScreenEditProfile,
                                 screen: EditProfileView(viewModel: viewModel.editPVM))
            }
        }
               .modifier(BackgroundElement(isProfile: true, headingText: "settings".localized))
               .onAppear {
                   viewModel.downloadProfile()
               }
    }
    
}

struct ProfileSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSettingsView(viewModel: ProfileSettingsViewModel(contentViewModel: ContentViewModel()))
    }
}
