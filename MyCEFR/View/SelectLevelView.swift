//
//  SelectLevelView.swift
//  MyCEFR
//
//  Created by Лаборатория on 06.06.2023.
//

import SwiftUI

struct SelectLevelView: View {
    
    var body: some View {
        VStack {
            Text("SelectLevel")
        }
        .modifier(BackgroundElement(headingText: "Select your level"))
    }
    
}

struct SelectLevelView_Previews: PreviewProvider {
    static var previews: some View {
        SelectLevelView()
    }
}
