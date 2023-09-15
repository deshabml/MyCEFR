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
                ImagePrifileView(size: 60)
                .environmentObject(coordinator)
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
//            viewModel.userProfile = coordinator.userProfile
//            viewModel.imagePVM.image = coordinator.imegeProfile
//            viewModel.setup(userProfile: coordinator.userProfile,
//                            image: coordinator.imegeProfile)
        }
    }
    
}
