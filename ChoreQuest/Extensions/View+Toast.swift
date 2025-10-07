//
//  View+Extensions.swift
//  ChoreQuest
//
//  Created by Leonardo Soares on 07/10/2025.
//

import SwiftUI

extension View {
    func toast() -> some View {
        self
            .modifier(ToastModifier())
    }
}
