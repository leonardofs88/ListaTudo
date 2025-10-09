//
//  ChoreListItemView.swift
//  ChoreQuest
//
//  Created by Leonardo Soares on 09/10/2025.
//

import SwiftUI

struct ChoreListItemView: View {
    
    @Environment(ChoreListingViewModel.self) private var listingViewModel
    
    @State private var title = ""
    @State private var description = ""
    @State private var titlePlaceholder = "Chore title"
    @State private var titleIsValid = true
    @FocusState private var titleFocusState: Bool
    
    @State private(set) var choreItemType: ChoreListItemType
    
    var body: some View {
        VStack {
            switch choreItemType {
                case .edit(let choreViewModel):
                    EditChoreListItem(
                        title: $title,
                        description: $description,
                        titlePlaceholder: $titlePlaceholder,
                        titleIsValid: $titleIsValid,
                        cancelAction: {
                            
                            title = ""
                            description = ""
                            
                            withAnimation(.smooth) {
                                choreItemType = .info(choreViewModel)
                            }
                        },
                        saveAction: {
                            Task {
                                titleValidator(title)
                                await saveAction()
                            }
                        },
                        deleteAction: {
                            Task {
                                await listingViewModel.removeChore(id: choreViewModel.id)
                            }
                        })
                    .onAppear {
                        title = choreViewModel.chore.title
                        description = choreViewModel.chore.description
                    }
                case .info(let choreViewModel):
                    HStack {
                        VStack(alignment: .leading) {
                            Text(choreViewModel.chore.title)
                                .font(.headline)
                                .fontWeight(.bold)
                            if !choreViewModel.chore.description.isEmpty {
                                Text(choreViewModel.chore.description)
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                            }
                        }
                        Spacer()
                            Button {
                                withAnimation(.smooth) {
                                    choreItemType = .edit(choreViewModel)
                                }
                            } label: {
                                Image(systemName: IconNames.Objects.pencilSquare)
                            }
                            .buttonStyle(ChoreQuestButtonStyle(backgroundColor: .greenFont))
                    }
                    .foregroundStyle(.greenFont)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.defaultGreen)
                            .shadow(color: .gray, radius: 2, x: 0, y: 2)
                    )
                    .frame(maxWidth: .infinity, alignment: .leading)
                case .add:
                    HStack {
                        Button {
                            withAnimation(.bouncy) {
                                choreItemType = .adding
                            }
                        } label: {
                            Label("Add chore", systemImage: IconNames.Control.plus)
                        }
                        .buttonStyle(ChoreQuestButtonStyle())
                    }
                    .frame(maxWidth: .infinity)
                    
                case .adding:
                    EditChoreListItem(
                        title: $title,
                        description: $description,
                        titlePlaceholder: $titlePlaceholder,
                        titleIsValid: $titleIsValid,
                        cancelAction: {
                            title = ""
                            description = ""
                            
                            withAnimation(.bouncy) {
                                choreItemType = .add
                            }
                        },
                        saveAction: {
                            Task {
                                titleValidator(title)
                                await saveAction()
                            }
                        })
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
    
    @MainActor
    private func saveAction() async {
        guard titleIsValid else { return }
        switch choreItemType {
            case .edit(let choreViewModel):
                await listingViewModel.saveChore(
                    id: choreViewModel.id,
                    title: title,
                    description: description
                )
                withAnimation(.bouncy) {
                    choreItemType = .info(choreViewModel)
                }
            case .adding:
                await listingViewModel.saveChore(
                    id: nil,
                    title: title,
                    description: description
                )
                title = ""
                description = ""
                
                withAnimation(.bouncy) {
                    choreItemType = .add
                }
            default:
                break
        }
    }
}

enum ChoreListItemType {
    case edit(ChoreViewModel)
    case info(ChoreViewModel)
    case add
    case adding
}

#Preview {
    Group {
        ChoreListItemView(
            choreItemType: .edit(
                ChoreViewModel(chore: ChoreData(id: UUID(), status: .toDo, title: "Preview", description: "Preview Description"))
            )
        )
        
        ChoreListItemView(
            choreItemType: .info(
                ChoreViewModel(chore: ChoreData(id: UUID(), status: .toDo, title: "Preview", description: "Preview Description"))
            )
        )
        
        ChoreListItemView(
            choreItemType: .add
        )
        
        ChoreListItemView(
            choreItemType: .adding
        )
        
    }
    .environment(ChoreListingViewModel(title: "Preview"))
}
