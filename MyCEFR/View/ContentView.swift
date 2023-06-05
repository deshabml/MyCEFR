//
//  ContentView.swift
//  MyCEFR
//
//  Created by Лаборатория on 24.05.2023.
//

import SwiftUI

struct ContentView: View {

    @StateObject var viewModel = ContentViewModel()

    var body: some View {
        VStack{
            if viewModel.isUser {
                ProfileSettingsView(viewModel: ProfileSettingsViewModel(contentViewModel: viewModel))
                    .preferredColorScheme(.light)
            } else {
                AuthorizationView(viewModel: AuthorizationViewModel(contentViewModel: viewModel))
                    .preferredColorScheme(.light)
            }
        }
        .animation(.easeInOut(duration: 0.4), value: viewModel.isUser)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
