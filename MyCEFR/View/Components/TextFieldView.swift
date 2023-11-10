//
//  TextFieldView.swift
//  MyCEFR
//
//  Created by Лаборатория on 27.05.2023.
//

import SwiftUI

struct TextFieldView: View {

    @StateObject var viewModel: TextFieldViewModel
    let size: CGFloat
    let width: CGFloat?
    let height: CGFloat?

    var body: some View {
        if let width, let height {
            TextField(viewModel.placeHolder, text: $viewModel.bindingProperty)
                .font(.custom("ItimCyrillic", size: size))
                .frame(width: width, height: height)
                .padding()
                .background(.white)
                .cornerRadius(8)
        } else {
            TextField(viewModel.placeHolder, text: $viewModel.bindingProperty)
                .font(.custom("ItimCyrillic", size: size))
                .frame(height: 25)
                .padding()
                .background(.white)
                .cornerRadius(8)
                .addBorder(viewModel.showError ? .red : .white,
                           width: 2,
                           cornerRadius: 8)
                .padding(.leading, viewModel.showError ? 5 : 0)
                .animation(Animation.spring(response: 0.2,
                                            dampingFraction: 0.1,
                                            blendDuration: 0.3),
                           value: viewModel.showError)
        }
    }
}

struct TextFieldView_Previews: PreviewProvider {

    static var previews: some View {
        TextFieldView(viewModel: TextFieldViewModel(placeHolder: "Demo"),
                      size: 24, width: 110, height: 20)
    }
}
