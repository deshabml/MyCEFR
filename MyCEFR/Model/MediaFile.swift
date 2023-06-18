//
//  MediaFile.swift
//  MyCEFR
//
//  Created by Лаборатория on 09.06.2023.
//

import Foundation

struct MediaFile: Identifiable {

    var id: String = UUID().uuidString
    var data: Data

}
