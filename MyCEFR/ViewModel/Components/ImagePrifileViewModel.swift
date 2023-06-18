//
//  ImagePrifileViewModel.swift
//  MyCEFR
//
//  Created by Лаборатория on 09.06.2023.
//

import UIKit

class ImagePrifileViewModel: ObservableObject {

    @Published var image: UIImage?

    func setImage(image: UIImage?) {
        self.image = image
    }

}
