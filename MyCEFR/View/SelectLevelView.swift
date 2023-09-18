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
            imageProfile()
            VStack {
                Text("SelectLevel")
            }
            .padding(.top, 200)
            Spacer()
        }
        .modifier(BackgroundElement(headingText: "selectYourLevel".localized))
    }
    
}

struct SelectLevelView_Previews: PreviewProvider {

    static var previews: some View {
        SelectLevelView(viewModel: SelectLevelViewModel())
            .environmentObject(Coordinator(isWorker: false))
    }

}

extension SelectLevelView {

    private func imageProfile() -> some View {
        HStack {
            Spacer()
            ImagePrifileView(size: 60)
                .environmentObject(coordinator)
                .onTapGesture {
                    coordinator.tab = .profile
                }
        }
        .padding(.top, -8)
        .padding(.horizontal, 8)
    }
    
}
