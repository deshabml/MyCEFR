//
//  Coordinator.swift
//  MyCEFR
//
//  Created by Лаборатория on 12.09.2023.
//

import SwiftUI

@MainActor
final class Coordinator: ObservableObject {

    @Published var pathHome = NavigationPath()
    @Published var pathProfile = NavigationPath()
    @Published var page: MyPage = .selectLevel
    @Published var tab: MyTab = MyTab.home
    @Published var isUser = false
    @Published var imegeProfile: UIImage? = nil
    @Published var userProfile: UserProfile = UserProfile(name: "firstAndlastName".localized,
                                                          eMail: "adress@email.ru",
                                                          phone: 88888888888,
                                                          imageUrl: "")
    @Published var selectLevel: Level = Level(id: "",
                                              name: "",
                                              fullName: "") {
        didSet {
            getSelectedWordsID()
        }
    }
    @Published var selectWords: [Word] = []
    @Published var selectedWordsID: SelectedWordsID = SelectedWordsID(id: "",
                                                                      selectedID: [])
    var currentUser = AuthService.shared.currentUser {
        didSet {
            findOutIsUser()
            downloadProfile()
        }
    }

    init(isWorker: Bool) {
        if isWorker {
            findOutIsUser()
            SMTPService.shared.getSMTPSetting()
            downloadProfile()
        }
    }

    func goHome() {
        pathHome.removeLast(pathHome.count)
    }

    func goToLevelScreen() {
        pathHome.append(MyPage.level)
    }

    func goBackHome() {
        pathHome.removeLast()
    }

    func goWordGroup() {
        pathHome.append(MyPage.wordGroup)
    }

    func goWordSelection(selectWords: [Word]) {
        self.selectWords = selectWords
        pathHome.append(MyPage.wordSelection)
    }

    @ViewBuilder
    func getPage(_ page: MyPage) -> some View {
        switch page {
            case .authorization:
                AuthorizationView(viewModel: AuthorizationViewModel())
            case .selectLevel:
                SelectLevelView(viewModel: SelectLevelViewModel())
            case .profileSettings:
                ProfileSettingsView(viewModel: ProfileSettingsViewModel())
            case .level:
                LevelView(viewModel: LevelViewModel(level: self.selectLevel))
            case .wordGroup:
                WordGroupView(viewModel: WordGroupViewModel(level: self.selectLevel))
            case .wordSelection:
                WordSelectionView(viewModel: WordSelectionViewModel(words: self.selectWords,
                                                                    level: self.selectLevel))
        }
    }
}

extension Coordinator {

    func updatingUser() {
        currentUser = AuthService.shared.currentUser
    }

    func findOutIsUser() {
        if currentUser != nil {
            isUser = true
        } else {
            isUser = false
        }
    }

    func getProfileImage() {
        StorageService.shared.getImage(imageUrl: userProfile.imageUrl) { result in
            switch result {
                case .success(let image):
                    self.imegeProfile = image
                case .failure(let error):
                    print(error)
            }
        }
    }

    func downloadProfile() {
        guard let user = AuthService.shared.currentUser else { return }
        Task {
            do {
                let userProfile = try await  FirestoreService.shared.getProfile(userId: user.uid)
                DispatchQueue.main.async { [unowned self] in
                    self.userProfile = userProfile
                    self.getProfileImage()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

extension Coordinator {

    func setupSelectLevel(level: Level) {
        selectLevel = level
    }

    func levelBackColor(level: Level) -> UIColor {
        let colorName = level.fullName.filter { $0 != "-" } + "BackColor"
        let color = UIColor(named: colorName)
        guard let color else { return UIColor.blue }
        return color
    }

    func getSelectedWordsID() {
        let id = "user:\(userProfile.id)_level:\(selectLevel.id)"
        selectedWordsID.id = id
        Task {
            do {
                let selectedWordsID = try await FirestoreService.shared.getSelectedWordsID(id)
                DispatchQueue.main.async {
                    self.selectedWordsID = selectedWordsID
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func editSelectedWordsID() {
        Task {
            do {
                try await FirestoreService.shared.editSelectedWordsID(selectedWordsID: selectedWordsID)
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func addSelectedWordsID(_ id: String) {
        selectedWordsID.selectedID.append(id)
        editSelectedWordsID()
    }

    func deleteSelectedWordsID(_ id: String) {
        let index = selectedWordsID.selectedID.firstIndex(of: id)
        guard let index else { return }
        selectedWordsID.selectedID.remove(at: index)
        editSelectedWordsID()
    }
}
