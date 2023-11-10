//
//  SMTPSetting.swift
//  MyCEFR
//
//  Created by Лаборатория on 18.06.2023.
//

import Foundation

struct SMTPSetting {

    var hostname: String
    var email: String
    var password: String
    var port: Int32
}

extension SMTPSetting {

    var representation: [String: Any] {
        var dict: [String: Any] = [:]
        dict["hostname"] = self.hostname
        dict["email"] = self.email
        dict["password"] = self.password
        dict["port"] = self.port
        return dict
    }

    init?(data: [String: Any]) {
        guard let hostname: String = data["hostname"] as? String,
              let email: String = data["email"] as? String,
              let password: String = data["password"] as? String,
              let port: Int32 = data["port"] as? Int32 else { return nil }
        self.hostname = hostname
        self.email = email
        self.password = password
        self.port = port
    }
}
