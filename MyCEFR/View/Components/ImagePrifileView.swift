//
//  ImagePrifileView.swift
//  MyCEFR
//
//  Created by Лаборатория on 09.06.2023.
//

import SwiftUI

struct ImagePrifileView: View {

    @StateObject var viewModel: ImagePrifileViewModel

    var body: some View {
        VStack {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .foregroundColor(.white)
                    .background(Color("MainBlueColor"))
            }
        }
    }

}
