//
//  ButtonView.swift
//  MyCEFR
//
//  Created by Лаборатория on 26.05.2023.
//

import SwiftUI

struct ButtonView: View {

    @StateObject var viewModel: ButtonViewModel
    let color: Color
    let width: CGFloat?

    var body: some View {
        Button {
            viewModel.action()
        } label: {
            if let width {
                Text(viewModel.buttonText)
                    .font(.custom("ItimCyrillic", size: 24))
                    .frame(width: width)
                    .foregroundColor(.black)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .background(color)
                    .cornerRadius(8)
            } else {
                Text(viewModel.buttonText)
                    .font(.custom("ItimCyrillic", size: 24))
                    .foregroundColor(.black)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .background(color)
                    .cornerRadius(8)
            }
        }
    }

}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(viewModel: ButtonViewModel(buttonText: "Отправить"),
                   color: Color("MainTopicColor"),
                   width: 110)
    }
}
