//
//  CircularProgressView.swift
//  MyCEFR
//
//  Created by Лаборатория on 15.09.2023.
//

import SwiftUI

struct CircularProgressView: View {

    @StateObject var viewModel: CircularProgressViewModel

    var body: some View {
        ZStack {
            if viewModel.progress > 0 {
                Circle()
                    .stroke(
                        Color("MainBlueColor").opacity(0.5),
                        lineWidth: 30
                    )
                Circle()
                    .trim(from: 0, to: viewModel.progress)
                    .stroke(
                        Color("MainBlueColor").opacity(0.9),
                        style: StrokeStyle(
                            lineWidth: 30,
                            lineCap: .round
                        )
                    )
                    .rotationEffect(.degrees(-90))
                    .animation(.easeOut, value: viewModel.progress)
            }
        }
    }
}

struct CircularProgressView_Previews: PreviewProvider {

    static var previews: some View {
        CircularProgressView(viewModel: CircularProgressViewModel())
    }
}
