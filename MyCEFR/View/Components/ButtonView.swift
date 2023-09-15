//
//  ButtonView.swift
//  MyCEFR
//
//  Created by Лаборатория on 26.05.2023.
//

import SwiftUI

struct ButtonView: View {

    @StateObject var viewModel: ButtonViewModel
    let color: (Color, Color)
    let width: CGFloat?
    var isBigButton = false

    var body: some View {
        Button {
            viewModel.action()
        } label: {
            if isBigButton {
                Text(viewModel.buttonText)
                    .font(.custom("ItimCyrillic", size: 24))
                    .frame(maxWidth: .infinity)
                    .foregroundColor(color.0)
                    .padding(.vertical, 10)
                    .background(color.1)
                    .cornerRadius(8)
            } else {
                if let width {
                    Text(viewModel.buttonText)
                        .font(.custom("ItimCyrillic", size: 24))
                        .frame(width: width)
                        .foregroundColor(color.0)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(color.1)
                        .cornerRadius(8)
                } else {
                    Text(viewModel.buttonText)
                        .font(.custom("ItimCyrillic", size: 24))
                        .foregroundColor(color.0)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(color.1)
                        .cornerRadius(8)
                }
            }
        }
    }

}

struct ButtonView_Previews: PreviewProvider {

    static var previews: some View {
        ButtonView(viewModel: ButtonViewModel(buttonText: "Send"),
                   color: (.black, Color("MainTopicColor")),
                   width: 110)
    }
    
}
