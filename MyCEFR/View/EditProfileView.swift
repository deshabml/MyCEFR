//
//  EditProfileView.swift
//  MyCEFR
//
//  Created by Лаборатория on 08.06.2023.
//

import SwiftUI

struct EditProfileView: View {

    @StateObject var viewModel: EditProfileViewModel

    var body: some View {
        VStack {
            HStack(spacing: 20) {
                TextFieldView(viewModel: viewModel.nameTFVM,
                              size: 20,
                              width: 180,
                              height: 24)
                .shadow(radius: 4)
                PhotoPickerRecipeView(viewModel: viewModel.image)
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
        .alert(viewModel.allertTextError, isPresented: $viewModel.showAllertError) {
            Button("ОК") { }
        }
    }

}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(viewModel: EditProfileViewModel())
    }
}
