//
//  LibraryView.swift
//  MyCEFR
//
//  Created by Лаборатория on 20.01.2024.
//

import SwiftUI

struct LibraryView: View {

    @EnvironmentObject var coordinator: Coordinator
    @StateObject var viewModel: LibraryViewModel

    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
        .modifier(BackgroundElement(isProfile: true,
                                    isFirstScreen: true,
                                    headingText: "settings".localized))
    }
}

#Preview {
    LibraryView(viewModel: LibraryViewModel())
}
