//
//  ImagePrifileView.swift
//  MyCEFR
//
//  Created by Лаборатория on 09.06.2023.
//

import SwiftUI

struct ImagePrifileView: View {
    
    @EnvironmentObject var coordinator: Coordinator
    
    let size: CGFloat
    
    var body: some View {
        VStack {
            if let image = coordinator.imegeProfile {
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
        .frame(width: size, height: size)
        .cornerRadius(size / 2)
        .addBorder(.white,
                   width: 6,
                   cornerRadius: size / 2)
        .addBorder(Color("MainBlueColor"),
                   width: 2,
                   cornerRadius: size / 2)
    }
    
}
