//
//  TabBarView.swift
//  MyCEFR
//
//  Created by Лаборатория on 06.06.2023.
//

import SwiftUI

struct TabBarView: View {

    @EnvironmentObject var contentViewModel: ContentViewModel

    var body: some View {
        NavigationView {
            TabView {
                SelectLevelView(viewModel: SelectLevelViewModel(contentViewModel: contentViewModel))
                    .tabItem {
                        Image(systemName: "house.fill")
                            .frame(width: 30, height: 30)
                    }
                ProfileSettingsView(viewModel: ProfileSettingsViewModel(contentViewModel: contentViewModel))
                    .tabItem {
                        Image(systemName: "person.fill")
                            .frame(width: 30, height: 30)
                    }
            }
        }
    }

}
