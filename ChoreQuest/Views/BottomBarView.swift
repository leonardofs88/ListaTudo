//
//  BottomBarView.swift
//  ChoreQuest
//
//  Created by Leonardo Soares on 09/10/2025.
//

import SwiftUI

struct BottomBarView: View {
    private(set) var cancelAction: () -> Void
    private(set) var saveAction: () -> Void
    private(set) var deleteAction: (() -> Void)?
    var body: some View {
        
        HStack {
            Button("Cancel", role: .destructive) {
                    cancelAction()
            }
            .buttonStyle(
                ChoreQuestButtonStyle(
                    padding: 8,
                    backgroundColor: .defaultRed
                )
            )
            Spacer()
            if let deleteAction {
                Button("Delete") {
                    deleteAction()
                }
                .buttonStyle(ChoreQuestButtonStyle(padding: 8, backgroundColor: .defaultRed))
            }
            Spacer()
            Button("Save") {
                    saveAction()
            }
            .buttonStyle(ChoreQuestButtonStyle(padding: 8))
        }
    }
}
