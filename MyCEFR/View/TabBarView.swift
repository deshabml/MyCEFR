//
//  TabBarView.swift
//  MyCEFR
//
//  Created by Лаборатория on 06.06.2023.
//

import SwiftUI

struct TabBarView: View {

    @EnvironmentObject var contentViewModel: ContentViewModel
    @State var selection: TabBarItems = .selectLevel

    var body: some View {
        NavigationView {
            TabView(selection: $selection) {
                SelectLevelView(viewModel: SelectLevelViewModel(contentViewModel: contentViewModel),
                                tab: $selection)
                    .tabItem {
                        Image(systemName: "house.fill")
                            .frame(width: 30, height: 30)
                    }
                    .tag(TabBarItems.selectLevel)
                ProfileSettingsView(viewModel: ProfileSettingsViewModel(contentViewModel: contentViewModel))
                    .tabItem {
                        Image(systemName: "person.fill")
                            .frame(width: 30, height: 30)
                    }
                    .tag(TabBarItems.profileSettings)
            }
        }
    }

}
