//
//  ChoreQuestButtonStyle.swift
//  ChoreQuest
//
//  Created by Leonardo Soares on 14/09/2025.
//

import SwiftUI

struct ChoreQuestButtonStyle: ButtonStyle {
    private(set) var padding: CGFloat
    private(set) var backgroundColor: Color
    private(set) var shape: ChoreQuestButtonShape
    
    init(
        padding: CGFloat = 12,
        backgroundColor: Color = .defaultBlue,
        shape: ChoreQuestButtonShape = .capsule
    ) {
        self.padding = padding
        self.backgroundColor = backgroundColor
        self.shape = shape
    }
    
    func makeBody(configuration: Configuration) -> some View {
        makeShape(configuration
            .label
            .font(.system(size: 20, weight: .semibold))
            .padding(padding)
            .foregroundStyle(.white)
        )
        .animation(
            .spring(duration: 0.1),
            value: configuration.isPressed
        )
        .scaleEffect(configuration.isPressed ? 0.9 : 1)
        .shadow(
            color: backgroundColor.opacity(0.7),
            radius: 0,
            x: configuration.isPressed ? 1 : 3,
            y: configuration.isPressed ? 1 : 3
        )
    }
    
    @ViewBuilder func makeShape(_ view: some View) -> some View {
        switch shape {
            case .roundedRectangle(let radius):
                view
                    .background(
                        backgroundColor
                            .clipShape(
                                RoundedRectangle(cornerRadius: radius)
                            )
                    )
            case .capsule:
                view
                    .background(
                        
                        backgroundColor.clipShape(
                            Capsule()
                        )
                    )
            case .circle:
                view
                    .background(
                        backgroundColor.clipShape(
                            Circle()
                        )
                    )
        }
    }
}

enum ChoreQuestButtonShape {
    case roundedRectangle(cornerRadius: CGFloat)
    case capsule
    case circle
}


#Preview {
    Button("Hello") {
        print("Circle Shape")
    }
    .buttonStyle(ChoreQuestButtonStyle(shape: .circle))
    
    Button("Hello") {
        print("Rounded Rectangle Shape")
    }
    .buttonStyle(ChoreQuestButtonStyle(shape: .roundedRectangle(cornerRadius: 12)))
    
    
    Button("Hello") {
        print("Capsule Shape")
    }
    .buttonStyle(ChoreQuestButtonStyle(shape: .capsule))
}
