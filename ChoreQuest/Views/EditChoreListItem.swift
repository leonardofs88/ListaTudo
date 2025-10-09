//
//  EditChoreListItem.swift
//  ChoreQuest
//
//  Created by Leonardo Soares on 09/10/2025.
//

import SwiftUI

struct EditChoreListItem: View {
    @Binding private(set) var title: String
    @Binding private(set) var description: String
    @Binding private(set) var titlePlaceholder: String
    @Binding private(set) var titleIsValid: Bool
    
    private(set) var cancelAction: () -> Void
    private(set) var saveAction: () -> Void
    private(set) var deleteAction: (() -> Void)?
    
    var body: some View {
        VStack {
            EditChoreFields(
                title: $title,
                description: $description,
                titlePlaceholder: $titlePlaceholder,
                titleIsValid: $titleIsValid
            )
            
            BottomBarView(
                cancelAction: cancelAction,
                saveAction: saveAction,
                deleteAction: deleteAction)
        }
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.orange.opacity(0.5))
                .shadow(color: .gray, radius: 2, x: 0, y: 2)
        )
    }
}

#Preview {
    EditChoreListItem(
        title: .constant("title"),
        description: .constant("description"),
        titlePlaceholder: .constant("Chore Title"),
        titleIsValid: .constant(true)
    ) {
        print("Cancel")
    } saveAction: {
        print("Save")
    }
    
}
