//
//  ChoreItemView.swift
//  ChoreQuest
//
//  Created by Leonardo Soares on 06/09/2025.
//

import SwiftUI

struct ChoreItemView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(ListingViewModel.self) private var listingViewModel
    @State private var title = ""
    @State private var description = ""
    @State private var titlePlaceholder = "Chore title"
    @State private var titleIsValid = true
    @State private(set) var choreViewModel: ChoreViewModel?
    var body: some View {
        NavigationStack {
            VStack() {
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
                            .shadow(color: .gray, radius: 2, x: 0, y: 2))
                    
                }
                .padding()
                Spacer()
            }
            .background(Color.orange.opacity(0.5))
            .toolbar(
                content: {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel", role: .destructive) {
                            dismiss()
                        }
                        .buttonStyle(ChoreQuestButtonStyle(padding: 8))
                    }
                    
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Save") {
                            titleValidator(title)
                            if titleIsValid {
                                listingViewModel.saveChore(
                                    id: choreViewModel?.id,
                                    title: title,
                                    description: description
                                )
                                dismiss()
                            }
                        }
                        .buttonStyle(ChoreQuestButtonStyle(padding: 8))
                    }
                })
            .onAppear {
                if let choreViewModel {
                    title = choreViewModel.chore.title
                    description = choreViewModel.chore.description
                }
            }
        }
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
    ChoreItemView()
        .environment(ListingViewModel(title: ""))
}
