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
        mainView
        .animation(.easeInOut(duration: 0.4), value: viewModel.isUser)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension ContentView {

    private var mainView: some View {
        VStack {
            if viewModel.isUser {
                TabBarView()
                    .environmentObject(viewModel)
            } else {
                AuthorizationView(viewModel: AuthorizationViewModel(contentViewModel: viewModel))
            }
        }
        .preferredColorScheme(.light)

    }

}
