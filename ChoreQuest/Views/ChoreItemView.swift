//
//  ChoreItemView.swift
//  ListaTudo
//
//  Created by Leonardo Soares on 06/09/2025.
//

import SwiftUI

struct ChoreItemView: View {
    @Environment(ListingViewModel.self) private var listingViewModel
    
    @State private var titlePlaceholder = "Chore title"
    @State private var titleIsValid = true
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var newItem = false
    @State private var choreID: UUID?
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField("", text: $title, prompt: Text(titlePlaceholder)
                .foregroundStyle(titleIsValid ? Color(uiColor: UIColor.placeholderText) : Color.red.opacity(0.7))
            )
            TextField("Chore description", text: $description)
        }
        .onAppear {
            if let choreID,
               let chore = listingViewModel.choreList
                .first(where: { $0.id == choreID }) {
                title = chore.chore.title
                description = chore.chore.description
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
