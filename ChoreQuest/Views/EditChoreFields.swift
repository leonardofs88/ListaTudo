//
//  EditChoreFields.swift
//  ChoreQuest
//
//  Created by Leonardo Soares on 09/10/2025.
//

import SwiftUI

struct EditChoreFields: View {
    @Binding private(set) var title: String
    @Binding private(set) var description: String
    @Binding private(set) var titlePlaceholder: String
    @Binding private(set) var titleIsValid: Bool
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                TextField(
                    "Chore title",
                    text: $title,
                    prompt: Text(titlePlaceholder)
                        .foregroundStyle(titleIsValid ? Color(uiColor: UIColor.placeholderText) : Color.red.opacity(0.7))
                )
                TextField("Chore description", text: $description)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                    .shadow(color: .gray, radius: 2, x: 0, y: 2)
            )
        }
        .padding()
    }
}

#Preview {
    EditChoreFields(
        title: .constant("VALID"),
        description: .constant("VALID"),
        titlePlaceholder: .constant("Chore title"),
        titleIsValid: .constant(
            true
        )
    )
}
