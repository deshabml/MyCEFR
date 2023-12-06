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
    @State var isShowAdminPanel = false

    var body: some View {
        VStack {
            ZStack {
                VStack {
                    imageProfile()
                    levels()
                    Spacer()
                }
                adminPanel()
            }

        }
        .modifier(BackgroundElement(isFirstScreen: true,
                                    headingText: "selectYourLevel".localized))
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

    private func levelCell(level: Level) -> some View {
        Button {
            coordinator.setupSelectLevel(level: level)
            if level.id == "1" {
                coordinator.goToLevelScreen()
            }
        } label: {
            VStack(alignment: .center, spacing: 35) {
                VStack(alignment: .center, spacing: 8) {
                    Text(level.name)
                    Text(level.fullName)
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
            .background {
                Color(uiColor: coordinator.levelBackColor(level: level))
            }
            .cornerRadius(18)
        }
    }

    private func levels() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            if viewModel.levels.isEmpty {
                ProgressView()
                    .progressViewStyle(.circular)
                    .padding(100)
            } else {
                HStack {
                    ForEach(viewModel.levels) {level in
                        levelCell(level: level)
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding(.top, 200)
    }    

    private func adminPanel() -> some View {
        VStack {
            Spacer()
            HStack {
                if isShowAdminPanel {
                    VStack(spacing: 50) {
                        buttonAdminPanel(text: "DownloadJson") {
                            viewModel.downloadJson()
                            print("DownloadJson")
                        }
                        Button {
                            isShowAdminPanel.toggle()
                        } label: {
                            Image(systemName: "xmark")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 16,
                                       height: 16)
                                .foregroundStyle(.black)
                        }

                        buttonAdminPanel(text: "UploadWords") {
                            viewModel.uploadWord()
                            print("UploadWords")
                        }
                    }
                    .background(.gray.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 40))
                } else {
                    Button {
                        isShowAdminPanel.toggle()
                    } label: {
                        Text("Панель Администратора")
                            .font(.custom("Spectral-Regular",
                                          size: 18))
                            .foregroundStyle(.black)
                    }
                    .padding()
                    .background(.gray.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(color: .blue.opacity(0.2), 
                            radius: 4)
                }
                Spacer()
            }
            .padding(.horizontal)
            .padding(.bottom, 100)
        }
        .animation(.linear, value: isShowAdminPanel)
    }

    private func buttonAdminPanel(text: String, completion: @escaping ()->()) -> some View {
        Button {
            completion()
        } label: {
            Text(text)
                .font(.custom("Spectral-Regular", size: 18))
                .foregroundStyle(.white)
        }
        .padding()
        .background(Color("MasteryBackColor"))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: .black.opacity(0.2), radius: 4)

    }
}
