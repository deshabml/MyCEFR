//
//  SMTPService.swift
//  MyCEFR
//
//  Created by Лаборатория on 27.05.2023.
//

import Foundation
import SwiftSMTP

class SMTPService {

    static let shared = SMTPService()

    private var smtp: SMTP?

    private init () { }

    func getSMTPSetting() {
        Task {
            do {
                let smtp = try await FirestoreService.shared.getSMTPSeting(id: "first")
                DispatchQueue.main.async { [unowned self] in
                    self.smtp = SMTP(hostname: smtp.hostname,
                                     email: smtp.email,
                                     password: smtp.password,
                                     port: smtp.port)
                }
            } catch {
                print("Error get SMTP setting")
            }
        }
    }

    func sendMail(mail: String, verificationCode: String, forgotPassword: Bool) async {
        let myCEFR = Mail.User(name: "MyCEFR", email: "drlight@gmail.com")
        let user = Mail.User(email: mail)
        let mail = Mail(
            from: myCEFR,
            to: [user],
            subject: "Код для подтверждения адреса электронной почты",
            text: """
            Ваш код \(forgotPassword ?  "для изменения пароля" : "для регистрации") в приложении MyCEFR:
            \(verificationCode)
            Если вы не отправляли запрос на регистрацию в нашем приложении,
            просто проигнорируйте это письмо.
            """)
        guard let smtp else {
            print("Error smtp")
            return
        }
        smtp.send(mail) { (error) in
            if let error = error {
                print(error)
            }
        }
    }
}

