//
//  GlassView.swift
//  MyCEFR
//
//  Created by Лаборатория on 06.12.2023.
//

import SwiftUI

struct GlassView: UIViewRepresentable {

    var removeEffects = false

    func makeUIView(context: Context) -> some UIView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterial))
        return view
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        DispatchQueue.main.async {
            if let subLayer = uiView.layer.sublayers?.first {
                if removeEffects {
                    subLayer.filters?.removeAll()
                } else {
                    subLayer.filters?.removeAll(where: { filter in
                        String(describing: filter) != "gaussianBlur"
                    })
                }
            }
        }
    }
}
