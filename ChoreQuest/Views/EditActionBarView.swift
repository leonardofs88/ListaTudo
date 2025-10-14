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
                Image(systemName: .arrowshapeTurnUpBackward)
            }
            .buttonStyle(
                ChoreQuestButtonStyle(
                    padding: 12,
                    backgroundColor: .defaultRed,
                    shape: .circle
                )
            )
            
            if let deleteAction {
                Spacer()
                
                Button(action: deleteAction) {
                    Image(systemName: .trash)
                }.buttonStyle(
                    ChoreQuestButtonStyle(
                        padding: 12,
                        backgroundColor: .defaultRed,
                        shape: .circle
                    )
                )
            }
            
            Spacer()
            
            Button(action: saveAction) {
                Image(systemName: .heartTextClipboard)
            }.buttonStyle(
                ChoreQuestButtonStyle(padding: 12,
                                      shape: .circle)
            )
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
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
