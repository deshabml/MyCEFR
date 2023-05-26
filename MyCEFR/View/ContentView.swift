//
//  ContentView.swift
//  MyCEFR
//
//  Created by Лаборатория on 24.05.2023.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        AuthorizationView()
            .preferredColorScheme(.light)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
