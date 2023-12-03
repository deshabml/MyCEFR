//
//  View.CornerRadiusStyle.swift
//  MyCEFR
//
//  Created by Лаборатория on 03.12.2023.
//

import SwiftUI

struct CornerRadiusStyle: ViewModifier {

    var radius: CGFloat
    var corners: UIRectCorner

    struct CornerRadiusShape: Shape {

        var radius = CGFloat.infinity
        var corners = UIRectCorner.allCorners

        func path(in rect: CGRect) -> Path {
            let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            return Path(path.cgPath)
        }
    }

    func body(content: Content) -> some View {
        content
            .clipShape(CornerRadiusShape(radius: radius, corners: corners))
    }
}

extension View {

    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        ModifiedContent(content: self, modifier: CornerRadiusStyle(radius: radius, corners: corners))
    }
//
//    public func addBorderCastumRadius(width: CGFloat = 1, cornerRadius: CGFloat, corners: UIRectCorner) -> some View {
////        let roundedRect = Rectangle()
//            ModifiedContent(content: self, modifier: cornerRadius(radius: cornerRadius, corners: corners))
//        return clipShape(roundedRect)
//             .overlay(roundedRect.strokeBorder(content, lineWidth: width))
//    }

//    func addBorderCastumRadius<T>(_ content: T, width: CGFloat = 1, cornerRadius: CGFloat) -> some View where T : ShapeStyle {
//        let roundedRect = RoundedRectangle(cornerRadius: cornerRadius)
//        return clipShape(Rectangle().cornerRadius(20, corners: [.topRight, .bottomRight]))
//             .overlay(roundedRect.strokeBorder(content, lineWidth: width))
//    }
}
