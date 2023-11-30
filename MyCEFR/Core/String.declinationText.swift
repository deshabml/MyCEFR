//
//  String.declinationText.swift
//  MyCEFR
//
//  Created by Лаборатория on 30.11.2023.
//

import Foundation

extension String {

    func declinationText(_ number: Int, _ textOne: String,_ textTwo: String,_ textThree: String) -> String {
        let nubmerTemp = number % 10
        return nubmerTemp == 1 ? textOne : nubmerTemp >= 5 || nubmerTemp == 0 || (11...19).contains(number) ? textTwo : textThree
    }
}
