//
//  ValidationAuthorization.swift
//  MyCEFR
//
//  Created by Лаборатория on 27.05.2023.
//

import Foundation

enum ErrorsAuthorization: Error {
    case emptyAll
    case emptyLogin
    case emptyPassword
    case shortPassword
    case nonExistentlogin
    case nonExistentPassword
    case notMail
}

final class ValidationAuthorization {

    static let shared = ValidationAuthorization()

    private init() { }

    func checkAuthorization(login: String, password: String) throws {
        guard login != "" || password != "" else { throw ErrorsAuthorization.emptyAll }
        guard login != "" else { throw ErrorsAuthorization.emptyLogin}
        guard password != "" else { throw ErrorsAuthorization.emptyPassword}
        guard isMail(login: login) else { throw ErrorsAuthorization.notMail }
        guard isSecurePassword(password: password) else { throw ErrorsAuthorization.shortPassword }
    }

    func isMail(login: String) -> Bool {
        let emailRegEx = "^[-a-z0-9!#$%&'*+/=?^_`{|}~]+(?:.[-a-z0-9!#$%&'*+/=?^_`{|}~]+)*@(?:[a-z0-9]([-a-z0-9]{0,61}[a-z0-9])?.)*(?:aero|arpa|asia|biz|cat|com|coop|edu|gov|info|int|jobs|mil|mobi|museum|name|net|org|pro|tel|travel|[a-z][a-z])$"
        let emailRegExSecond = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let emailPredSecond = NSPredicate(format:"SELF MATCHES %@", emailRegExSecond)
        return emailPred.evaluate(with: login) && emailPredSecond.evaluate(with: login)
    }

    func isSecurePassword(password: String) -> Bool {
        let passwordRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,}$"
        let passwordPred = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return passwordPred.evaluate(with: password)
    }
}
