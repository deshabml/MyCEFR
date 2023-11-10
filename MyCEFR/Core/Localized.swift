//
//  Localized.swift
//  MyCEFR
//
//  Created by Лаборатория on 25.06.2023.
//

import Foundation

extension String {

    var localized: String {
        NSLocalizedString(self, comment: "Ключ \(self) не найден")
    }

    func localizedPlural(_ argument: Int) -> String {
        let format = NSLocalizedString(self, comment: "\(self) не удалось локализовать")
        let localized = Self.localizedStringWithFormat(format, argument)
        return localized
    }
}
