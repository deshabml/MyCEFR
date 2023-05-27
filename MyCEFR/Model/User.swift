//
//  User.swift
//  MyCEFR
//
//  Created by Лаборатория on 27.05.2023.
//

import Foundation
import RealmSwift

class User: Object, Identifiable {

    @Persisted(primaryKey: true) var id = UUID().uuidString
    @Persisted var name: String
    @Persisted var eMail: String
    @Persisted var passwordHash: String
    @Persisted var avatarImage: Data
    @Persisted var isNotificationsEnabled: Bool = false

    convenience init(name: String, eMail: String, passwordHash: String) {
        self.init()
        self.name = name
        self.eMail = eMail
        self.passwordHash = passwordHash
    }

}
