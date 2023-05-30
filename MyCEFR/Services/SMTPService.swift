//
//  SMTPService.swift
//  MyCEFR
//
//  Created by Лаборатория on 27.05.2023.
//

import SwiftSMTP

class SMTPService {

    static let shared = SMTPService()

    // MARK: - Задаем параметры SMTP сервера
    private let smtp = SMTP(
        hostname: "smtp.gmail.com",
        email: "robmycefr@gmail.com",
        password: "mdiiunkcsvdfydiw",
        port: 587
    )

    private init () { }

    // MARK: - Отправляем письмо с кодом верификации
    func sendMail(mail: String, verificationCode: String) async {
        let myCEFR = Mail.User(name: "MyCEFR", email: "drlight@gmail.com")
        let user = Mail.User(email: mail)
        let mail = Mail(
            from: myCEFR,
            to: [user],
            subject: "Код для подтверждения адреса электронной почты",
            text: """
            Ваш код для регистрации а приложении MyCEFR:
            \(verificationCode)
            Если вы не отправляли запрос на регистрацию в нашем приложении,
            просто проигнорируйте это письмо.
            """)
        smtp.send(mail) { (error) in
            if let error = error {
                print(error)
            }
        }
    }

}

