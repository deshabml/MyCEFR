//
//  ChoosingStudyMethodView.swift
//  MyCEFR
//
//  Created by Лаборатория on 01.12.2023.
//

import SwiftUI

struct ChoosingStudyMethodView: View {

    @EnvironmentObject var coordinator: Coordinator
    
    var body: some View {
        VStack {
            choosingStudyMethodButton("flashcards".localized,
                                      "wordsReview".localized,
                                      completion: {
                print("Screen Show")
            })
            fakeButton("learn".localized,
                       "learnWords".localized)
            fakeButton("test".localized,
                       "TakeATestToCheckYourKnowledge".localized)
        }
        .padding()
    }
}

#Preview {
    ChoosingStudyMethodView()
}

extension ChoosingStudyMethodView {

    private func choosingStudyMethodButton(_ heading: String,_ explanation: String, completion: @escaping ()->()) -> some View {
        Button {
            completion()
        } label: {
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text(heading)
                        .font(Font.custom("Spectral", size: 22)
                            .weight(.semibold))
                        .foregroundStyle(.white)
                    Text(explanation)
                        .font(Font.custom("Spectral", size: 16)
                            .weight(.semibold))
                        .foregroundStyle(Color(red: 0.59, green: 0.59, blue: 0.59))
                }
                .padding(.horizontal)
                Spacer()
            }
        }
        .frame(width: 300, height: 70)
        .background(Color("MainBlueColor"))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(.bottom, 16)
    }

    private func fakeButton(_ heading: String,_ explanation: String) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 0) {
                Text(heading)
                    .font(Font.custom("Spectral", size: 22)
                        .weight(.semibold))
                    .foregroundStyle(.white)
                Text(explanation)
                    .font(Font.custom("Spectral", size: 16)
                        .weight(.semibold))
                    .foregroundStyle(Color(red: 0.59, green: 0.59, blue: 0.59))
            }
            .padding(.horizontal)
            Spacer()
        }
        .frame(width: 300, height: 70)
        .background(Color("MainBlueColor").opacity(0.4))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(.bottom, 16)
    }
}
