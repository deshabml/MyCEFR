//
//  User.swift
//  MyCEFR
//
//  Created by Лаборатория on 27.05.2023.
//

import Foundation

struct UserProfile: Identifiable {

    var id: String = UUID().uuidString
    var name: String
    var eMail: String
    var phone: Int
    var imageUrl: String
}

extension UserProfile {

    var representation: [String: Any] {
        var dict: [String: Any] = [:]
        dict["id"] = self.id
        dict["name"] = self.name
        dict["eMail"] = self.eMail
        dict["phone"] = self.phone
        dict["imageUrl"] = self.imageUrl
        return dict
    }

    init?(data: [String: Any]) {
        guard let id: String = data["id"] as? String,
              let name: String = data["name"] as? String,
              let eMail: String = data["eMail"] as? String,
              let phone: Int = data["phone"] as? Int,
              let imageUrl: String = data["imageUrl"] as? String else { return nil }
        self.id = id
        self.name = name
        self.eMail = eMail
        self.phone = phone
        self.imageUrl = imageUrl
    }
}
