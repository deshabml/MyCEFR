//
//  SMTPService.swift
//  MyCEFR
//
//  Created by Лаборатория on 27.05.2023.
//

import SwiftSMTP

class SMTPService {

    static let shared = SMTPService()

    private let smtp = SMTP(
        hostname: "smtp.gmail.com",
        email: "robmycefr@gmail.com",
        password: "mdiiunkcsvdfydiw",
        port: 587
    )

    private init () { }

    func sendMail(mail: String, verificationCode: String) {
        let myCEFR = Mail.User(name: "MyCEFR", email: "drlight@gmail.com")
        let user = Mail.User(email: mail)
        let mail = Mail(
            from: myCEFR,
            to: [user],
            subject: "Код для подтверждения адреса электронной почты",
            text: """
            Ваш код для регистрации а приложении MyCEFR:
            \(verificationCode)
            Если вы не отправляли запро на регистрацию в нашем приложении,
            просто проигнорируйте это письмо.
            """)
        smtp.send(mail) { (error) in
            if let error = error {
                print(error)
            }
        }
    }

}

