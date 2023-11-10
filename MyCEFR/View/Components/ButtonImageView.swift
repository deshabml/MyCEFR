//
//  ButtonImageView.swift
//  MyCEFR
//
//  Created by Лаборатория on 26.05.2023.
//

import SwiftUI

struct ButtonImageView: View {

    @StateObject var viewModel: ButtonImageViewModel

    var body: some View {
        Button {
            viewModel.action()
        } label: {
            Image(systemName: viewModel.imageSystemName)
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(Color("RedTopicColor"))
                .padding(.horizontal, 8)
        }
    }
}

struct ButtonImageView_Previews: PreviewProvider {

    static var previews: some View {
        ButtonImageView(viewModel: ButtonImageViewModel(imageSystemName: "square.and.pencil"))
    }
}
