//
//  RealmService.swift
//  MyCEFR
//
//  Created by Лаборатория on 27.05.2023.
//

import Foundation
import RealmSwift

class RealmService {

    static let shared = RealmService()
    private let dataBase = try! Realm()

    private init() { }

    func createObject<T>(object: T) {
        guard let object = object as? Object else { return }
        do {
            try dataBase.write {
                dataBase.add(object)
            }
        } catch {
            print("Неисправность базы данных")
        }
    }

    func deleteObject<T>(object: T) {
        guard let object = object as? Object else { return }
        do {
            try dataBase.write {
                dataBase.delete(object)
            }
        } catch {
            print("Неисправность базы данных")
        }
    }

}

extension RealmService {

    func getUsers() -> [User] {
        let userList = dataBase.objects(User.self)
        var users: [User] = []
        for user in userList {
            users.append(user)
        }
        return users
    }

}
