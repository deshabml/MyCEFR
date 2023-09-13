//
//  SelectLevelView.swift
//  MyCEFR
//
//  Created by Лаборатория on 06.06.2023.
//

import SwiftUI

struct SelectLevelView: View {

    @EnvironmentObject var coordinator: Coordinator
    @StateObject var viewModel: SelectLevelViewModel
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                ImagePrifileView(viewModel: viewModel.imagePVM,
                                 size: 60)
                .onTapGesture {
                    coordinator.tab = .profile
                }
            }
            VStack {
                Text("SelectLevel")
            }
            .padding(.top, 200)
            Spacer()
        }
        .padding()
        .modifier(BackgroundElement(headingText: "selectYourLevel".localized))
        .onAppear {
            viewModel.downloadProfile()
        }
    }
    
}
