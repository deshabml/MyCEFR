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
        if viewModel.isLoggedIn {
            ProfileSettingsView(viewModel: viewModel.psvm)
                .preferredColorScheme(.light)
        } else {
            AuthorizationView()
                .preferredColorScheme(.light)
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
