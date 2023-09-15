//
//  PhotoPickerRecipeView.swift
//  MyCEFR
//
//  Created by Лаборатория on 09.06.2023.
//

import SwiftUI
import PhotosUI

struct PhotoPickerView: View {

    @StateObject var viewModel: PhotoPickerViewModel

    var body: some View {
        PhotosPicker(selection: $viewModel.selectedPhoto, matching: .images) {
            viewModel.imageForPresentation
                .resizable()
                .scaledToFill()
                .foregroundColor(.white)
                .background(Color("MainBlueColor"))
                .frame(width: 100, height: 100)
                .cornerRadius(50)
                .shadow(color: .black, radius: 8)
        }
    }

}
