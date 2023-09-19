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
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    level()
                    level()
                    level()
                    level()
                    level()
                    level()
                }
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

    private func level() -> some View {
        VStack(alignment: .center, spacing: 35) {
            VStack(alignment: .center, spacing: 8) {
                Text("A1")
                Text("Elementary")
            }
            .padding(.top)
            ProgressView(value: 0.3)
                .progressViewStyle(.linear)
                .frame(height: 8)
                .tint(Color("ProgressLevelColor"))
                .background(Color("ProgressBackLevelColor"))
                .cornerRadius(4)
                .padding(.horizontal)
        }
        .modifier(TextElement(size: 28,
                              verticalPadding: 40,
                              foregroundColor: .white))
        .frame(width: 244, height: 144)
        .background(Color("MainBlueColor"))
        .cornerRadius(18)
        .padding(.leading, 16)
    }
    
}
