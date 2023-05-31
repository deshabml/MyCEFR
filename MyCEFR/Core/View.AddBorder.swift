//
//  View.AddBorder.swift
//  MyCEFR
//
//  Created by Лаборатория on 31.05.2023.
//

import SwiftUI

extension View {

     public func addBorder<T>(_ content: T, width: CGFloat = 1, cornerRadius: CGFloat) -> some View where T : ShapeStyle {
         let roundedRect = RoundedRectangle(cornerRadius: cornerRadius)
         return clipShape(roundedRect)
              .overlay(roundedRect.strokeBorder(content, lineWidth: width))
     }

 }
