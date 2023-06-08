//
//  SelectLevelView.swift
//  MyCEFR
//
//  Created by Лаборатория on 06.06.2023.
//

import SwiftUI

struct SelectLevelView: View {

    @StateObject var viewModel: SelectLevelViewModel
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
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
                .frame(width: 60, height: 60)
                .cornerRadius(30)
                .addBorder(.white,
                           width: 6,
                           cornerRadius: 30)
                .addBorder(Color("MainBlueColor"),
                           width: 2,
                           cornerRadius: 30)
            }
            VStack {
                Text("SelectLevel")
            }
            .padding(.top, 200)
            Spacer()
        }
        .modifier(BackgroundElement(headingText: "Select your level"))
    }
    
}

struct SelectLevelView_Previews: PreviewProvider {
    static var previews: some View {
        SelectLevelView(viewModel: SelectLevelViewModel(contentViewModel: ContentViewModel()))
    }
}
