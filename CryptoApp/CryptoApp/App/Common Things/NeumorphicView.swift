//
//  NeumorphicView.swift
//  CryptoApp
//
//  Created by Gabriel Alejandro Briseño Alvarez on 13/03/25.
//
import SwiftUI

struct NeumorphicView: View {
    private let backgroundColor = Color(.systemGray6)
    @State private var isPressed = false

    var body: some View {
        let shadowAtTheTopLeft = shadowAtTheTopLeft()
        let shadowAtTheBottomRight = shadowAtTheBottomRight()
        RoundedRectangle(cornerRadius: 20)
            .fill(backgroundColor)
            .frame(minWidth: 150, maxWidth: .infinity, minHeight: 150, maxHeight: .infinity)
            .shadow(color: shadowAtTheTopLeft.color, radius: 5, x: shadowAtTheTopLeft.xCoord, y: shadowAtTheTopLeft.yCoord)
            .shadow(color: shadowAtTheBottomRight.color, radius: 5, x: shadowAtTheBottomRight.xCoord, y: shadowAtTheBottomRight.yCoord)
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in isPressed = true }
                    .onEnded { _ in isPressed = false }
            )
            .animation(.default, value: isPressed)
    }
    
    func shadowAtTheTopLeft() -> (color: Color, xCoord: CGFloat, yCoord: CGFloat) {
        (color: isPressed ? Color.black.opacity(0.2) : Color.black.opacity(0.6),
         xCoord: isPressed ? 5 : -5,
         yCoord: isPressed ? 5 : -5)
    }
    
    func shadowAtTheBottomRight() -> (color: Color, xCoord: CGFloat, yCoord: CGFloat) {
        (color: isPressed ? Color.white.opacity(0.6) : Color.white.opacity(0.2),
         xCoord: isPressed ? -5 : 5,
         yCoord: isPressed ? -5 : 5)
    }
}
