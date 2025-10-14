//
//  EditChoreListItem.swift
//  ChoreQuest
//
//  Created by Leonardo Soares on 09/10/2025.
//

import SwiftUI

struct EditChoreListItem: View {
    @Binding var title: String
    @Binding var description: String
    
    @State var titlePlaceholder = "Chore Title"
    @State var titleIsValid: Bool = true
    
    private(set) var saveAction: () -> Void
    private(set) var cancelAction: () -> Void
    private(set) var deleteAction: (() -> Void)?
    
    var body: some View {
        VStack {
            EditChoreFields(
                title: $title,
                description: $description,
                titlePlaceholder: $titlePlaceholder,
                titleIsValid: $titleIsValid
            )
            
            EditActionBarView(
                saveAction: {
                    titleValidator(title)
                    if titleIsValid {
                        withAnimation(.bouncy) {
                            saveAction()
                        }
                    }
                },
                cancelAction:
                    {
                        title = ""
                        description = ""
                        titleIsValid = true
                        withAnimation(.bouncy) {
                            cancelAction()
                        }
                    },
                deleteAction: deleteAction)
        }
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.orange.opacity(0.5))
                .shadow(color: .gray, radius: 2, x: 0, y: 2)
        )
    }
    
    private func titleValidator(_ title: String) {
        if title.isEmpty {
            titlePlaceholder = "Title cannot be empty"
            titleIsValid = false
        } else {
            titleIsValid = true
        }
    }
}

#Preview {
    EditChoreListItem(
        title: .constant("a"),
        description: .constant("b"),
        saveAction: {
            print("Save")
        },
        cancelAction: {
            print("Cancel")
        }
    )
}
