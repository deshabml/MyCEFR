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
                ImagePrifileView(viewModel: viewModel.imagePVM)
                .frame(width: 60, height: 60)
                .cornerRadius(30)
                .addBorder(.white,
                           width: 6,
                           cornerRadius: 30)
                .addBorder(Color("MainBlueColor"),
                           width: 2,
                           cornerRadius: 30)
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
