//
//  ChoreItemView.swift
//  ChoreQuest
//
//  Created by Leonardo Soares on 06/09/2025.
//

import SwiftUI

struct ChoreItemView: View {
    
    @Environment(ChoreListingViewModel.self) private var listingViewModel
    
    @State private var title = ""
    @State private var description = ""
    @State private var titlePlaceholder = "Chore title"
    @State private var titleIsValid = true
    
    @State private(set) var choreViewModel: ChoreViewModel?
    
    @Binding private(set) var isPresented: Bool
    
    var animation: Namespace.ID
    
    var body: some View {
        VStack {
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
            HStack {
                Button("Cancel", role: .destructive) {
                    withAnimation(.spring(.snappy, blendDuration: 0.3)) {
                        isPresented = false
                    }
                }
                .buttonStyle(
                    ChoreQuestButtonStyle(
                        padding: 8,
                        backgroundColor: ColorNames.defaultRed
                    )
                )
                Spacer()
                Button("Save") {
                    titleValidator(title)
                    
                    withAnimation(.spring(.snappy, blendDuration: 0.3)) {
                        if titleIsValid {
                            listingViewModel.saveChore(
                                id: choreViewModel?.id,
                                title: title,
                                description: description
                            )
                            isPresented = false
                        }
                    }
                }
                .buttonStyle(ChoreQuestButtonStyle(padding: 8))
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.orange.opacity(0.5))
                .shadow(color: .gray, radius: 2, x: 0, y: 2)
        )
        .transition(.move(edge: .top))
        .matchedGeometryEffect(
            id: "addChore",
            in: animation,
            anchor: .top,
            isSource: false
        )
        .onAppear {
            if let choreViewModel {
                title = choreViewModel.chore.title
                description = choreViewModel.chore.description
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
    @Previewable @Namespace var animation
    ChoreItemView(isPresented: .constant(true), animation: animation)
        .environment(ChoreListingViewModel(title: ""))
}
