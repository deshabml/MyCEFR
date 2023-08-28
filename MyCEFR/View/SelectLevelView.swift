//
//  SelectLevelView.swift
//  MyCEFR
//
//  Created by Лаборатория on 06.06.2023.
//

import SwiftUI

struct SelectLevelView: View {

    @StateObject var viewModel: SelectLevelViewModel
    @Binding var tab: TabBarItems
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                ImagePrifileView(viewModel: viewModel.imagePVM,
                                 size: 60)
                .onTapGesture {
                    tab = .profileSettings
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
    }
    
}
