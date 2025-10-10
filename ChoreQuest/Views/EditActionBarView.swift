//
//  ThreeActionBarView.swift
//  ChoreQuest
//
//  Created by Leonardo Soares on 09/10/2025.
//

import SwiftUI

struct EditActionBarView: View {
    
    private(set) var saveAction: () -> Void
    private(set) var cancelAction: () -> Void
    private(set) var deleteAction: (() -> Void)?
    var body: some View {
        
        HStack {
            Button(action: cancelAction) {
                Image(systemName: "arrowshape.turn.up.backward")
            }
            .buttonStyle(
                ChoreQuestButtonStyle(
                    padding: 8,
                    backgroundColor: .defaultRed
                )
            )
            
            if let deleteAction {
                Spacer()
                
                Button(action: deleteAction) {
                    Image(systemName: "trash")
                }.buttonStyle(
                    ChoreQuestButtonStyle(
                        padding: 8,
                        backgroundColor: .defaultRed
                    )
                )
            }
            
            Spacer()
            
            Button(action: saveAction) {
                Image(systemName: "heart.text.clipboard")
            }.buttonStyle(ChoreQuestButtonStyle(padding: 8))
        }
    }
}

#Preview {
    EditActionBarView {
        print("Cancel")
    } cancelAction: {
        print("Save")
    } deleteAction: {
        print("Delete")
    }
}
