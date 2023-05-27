//
//  SecureFieldView.swift
//  MyCEFR
//
//  Created by Лаборатория on 26.05.2023.
//

import SwiftUI

struct SecureFieldView: View {

    @StateObject var viewModel: SecureFieldViewModel

    var body: some View {
        ZStack {
            if viewModel.showPassword {
                TextField(viewModel.placeHolder, text: $viewModel.bindingProperty)
                    .font(.custom("ItimCyrillic", size: 18))
                    .frame(height: 25)
                    .padding()
                    .background(.white)
                    .cornerRadius(8)
            } else {
                SecureField(viewModel.placeHolder, text: $viewModel.bindingProperty)
                    .font(.custom("ItimCyrillic", size: 18))
                    .frame(height: 25)
                    .padding()
                    .background(.white)
                    .cornerRadius(8)
            }
            HStack {
                Spacer()
                Button {
                    viewModel.showPassword.toggle()
                } label: {
                    Image(systemName: viewModel.showPassword ? "eye.fill" : "eye.slash.fill")
                        .foregroundColor(.gray)
                        .padding(.trailing, viewModel.isThereButton ? 106 : 8)
                }
            }
        }
    }

}

struct SecureFieldView_Previews: PreviewProvider {
    static var previews: some View {
        SecureFieldView(viewModel: SecureFieldViewModel())
    }
}
