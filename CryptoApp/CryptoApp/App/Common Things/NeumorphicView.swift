//
//  NeumorphicView.swift
//  CryptoApp
//
//  Created by Gabriel Alejandro Briseño Alvarez on 13/03/25.
//
import SwiftUI

struct NeumorphicView: View {
    let isInteractive: Bool

    @State private var isPressed = false
    @Environment(\.colorScheme) var colorScheme
    
    private var backgroundColor: Color {
        colorScheme == .dark ? .neumorphicDark() : .neumorphicLight()
    }

    var body: some View {
        if isInteractive {
            shadowForInteractiveView()
                .simultaneousGesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { _ in isPressed = true }
                        .onEnded { _ in isPressed = false }
                )
                .animation(.default, value: isPressed)
        } else {
            shadowForUninteractiveView()
        }
    }
    
    func shadowForInteractiveView() -> some View {
        let shadowAtTheTopLeft = (color: isPressed ? Color.black.opacity(0.2) : Color.black.opacity(0.6),
                                  xCoord: isPressed ? -5.0 : 5.0,
                                  yCoord: isPressed ? -5.0 : 5.0)
        
        let shadowAtTheBottomRight = (color: isPressed ? Color.white.opacity(0.6) : Color.white.opacity(0.2),
                                      xCoord: isPressed ? 5.0 : -5.0,
                                      yCoord: isPressed ? 5.0 : -5.0)

        return RoundedRectangle(cornerRadius: 20)
            .fill(backgroundColor)
            .frame(minWidth: 150, maxWidth: .infinity, minHeight: 150, maxHeight: .infinity)
            .shadow(color: shadowAtTheTopLeft.color, radius: 5, x: shadowAtTheTopLeft.xCoord, y: shadowAtTheTopLeft.yCoord)
            .shadow(color: shadowAtTheBottomRight.color, radius: 5, x: shadowAtTheBottomRight.xCoord, y: shadowAtTheBottomRight.yCoord)
    }
    
    func shadowForUninteractiveView() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.black.opacity(0.1), lineWidth: 1)
                .blur(radius: 5)
                .offset(x: -5, y: -5)
                .mask(RoundedRectangle(cornerRadius: 20).fill(LinearGradient(gradient: Gradient(colors: [Color.gray]), startPoint: .topLeading, endPoint: .bottomTrailing)))
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.black, lineWidth: 1)
                .blur(radius: 5)
                .offset(x: 5, y: 5)
                .mask(RoundedRectangle(cornerRadius: 20).fill(LinearGradient(gradient: Gradient(colors: [Color.yellow]), startPoint: .topTrailing, endPoint: .bottomLeading)))
        }
        .background(backgroundColor)
        .frame(minWidth: 150, maxWidth: .infinity, minHeight: 150, maxHeight: .infinity)
    }
}
