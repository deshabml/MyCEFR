//
//  ProfileSettingsView.swift
//  MyCEFR
//
//  Created by Лаборатория on 31.05.2023.
//

import SwiftUI

struct ProfileSettingsView: View {

    @EnvironmentObject var coordinator: Coordinator
    @StateObject var viewModel: ProfileSettingsViewModel
    
    var body: some View {
        VStack(alignment: .center,
               spacing: 12) {
            VStack(spacing: 100) {
                HStack() {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(coordinator.userProfile.name)
                            .modifier(TextElement(size: 25, foregroundColor: .black))
                        Text(coordinator.userProfile.eMail)
                            .modifier(TextElement(size: 18, foregroundColor: .gray))
                    }
                    Spacer()
                    ImagePrifileView(size: 100)
                        .environmentObject(coordinator)
                        .overlay {
                            CircularProgressView(viewvModel: viewModel.editPVM.progressUploadPhotosCPVM)
                                .frame(width: 60, height: 60)
                        }
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
            .overlay {
                ShowScreenEPView(viewModel: viewModel.editPVM.showScreenEditProfile,
                                 screen: EditProfileView(viewModel: viewModel.editPVM))
                .environmentObject(coordinator)
            }
        }
               .modifier(BackgroundElement(isProfile: true, headingText: "settings".localized))
               .onAppear {
                   viewModel.setup { coordinator.updatingUser() }
               }
    }
    
}

struct ProfileSettingsView_Previews: PreviewProvider {

    static var previews: some View {
        ProfileSettingsView(viewModel: ProfileSettingsViewModel())
            .environmentObject(Coordinator(isWorker: false))
    }
    
}
