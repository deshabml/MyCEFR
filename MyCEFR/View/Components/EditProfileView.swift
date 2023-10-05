//
//  EditProfileView.swift
//  MyCEFR
//
//  Created by Лаборатория on 08.06.2023.
//

import SwiftUI

struct EditProfileView: View {

    @EnvironmentObject var coordinator: Coordinator
    @StateObject var viewModel: EditProfileViewModel

    var body: some View {
        VStack {
            HStack(spacing: 20) {
                TextFieldView(viewModel: viewModel.nameTFVM,
                              size: 20,
                              width: 180,
                              height: 24)
                .shadow(radius: 4)
                PhotoPickerView(viewModel: viewModel.image)
            }
            HStack {
                ButtonView(viewModel: viewModel.saveButtonVM,
                           color: (.white, Color("MainBlueColor")),
                           width: 120)
                ButtonView(viewModel: viewModel.cancelButtonVM,
                           color: (.white, Color("MainBlueColor")),
                           width: 120)
            }
        }
        .padding()
        .background(.white)
        .alert(viewModel.allertTextError, isPresented: $viewModel.showAllertError) {
            Button("ОК") { }
        }
        .onAppear {
            onApperAction()
        }
    }

}

struct EditProfileView_Previews: PreviewProvider {

    static var previews: some View {
        EditProfileView(viewModel: EditProfileViewModel())
            .environmentObject(Coordinator(isWorker: false))
    }
    
}

extension EditProfileView {

    private func onApperAction() {
        viewModel.setUserProfile(userProfile: coordinator.userProfile)
        viewModel.bindingPropertySetup()
        viewModel.sutupCompition { coordinator.downloadProfile() }
        if let image = coordinator.imegeProfile {
            viewModel.image.setupImageStandard(Image(uiImage: image))
        }
    }

}
