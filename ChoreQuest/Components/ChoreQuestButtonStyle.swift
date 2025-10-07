//
//  ChoreQuestButtonStyle.swift
//  ChoreQuest
//
//  Created by Leonardo Soares on 14/09/2025.
//

import SwiftUI

struct ChoreQuestButtonStyle: ButtonStyle {
    @State private(set) var padding: CGFloat
    @State private(set) var backgroundColor: Color
    
    init(padding: CGFloat = 12, backgroundColor: Color = ColorNames.defaultBlue) {
        self.padding = padding
        self.backgroundColor = backgroundColor
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(padding)
            .background(backgroundColor)
            .foregroundStyle(.white)
            .clipShape(Capsule())
            .shadow(color: .gray, radius: 2, x: 2, y: 2)
    }
}
