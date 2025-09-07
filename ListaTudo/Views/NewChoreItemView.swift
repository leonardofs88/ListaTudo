//
//  NewChoreItemView.swift
//  ListaTudo
//
//  Created by Leonardo Soares on 06/09/2025.
//

import SwiftUI

struct NewChoreItemView: View {
    @Environment(ListingViewModel.self) private var listingViewModel
    
    @State private var titlePlaceholder = "Chore title"
    @State private var titleIsValid = true
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var newItem = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Button {
                withAnimation {
                    newItem.toggle()
                }
            } label: {
                if newItem {
                    Button {
                        titleValidator(title)
                        if titleIsValid {
                            newItem = false
                            listingViewModel.createNewChore(
                                title,
                                description: description
                            )
                            title = ""
                            description = ""
                        }
                    } label: {
                        Text("Save")
                            .transition(
                                .push(from: .bottom)
                                .combined(with: .opacity)
                            )
                    }
                } else {
                    Image(systemName: "plus.circle")
                        .transition(
                            .push(from: .top)
                            .combined(with: .opacity)
                        )
                }
            }
            
            if newItem {
                TextField("", text: $title, prompt: Text(titlePlaceholder)
                    .foregroundStyle(titleIsValid ? Color(uiColor: UIColor.placeholderText) : Color.red.opacity(0.7))
                )
                TextField("E.g.: Use the good soap", text: $description)
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
    NewChoreItemView()
        .environment(ListingViewModel(title: ""))
}
