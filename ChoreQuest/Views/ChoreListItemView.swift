//
//  ChoreListItemView.swift
//  ChoreQuest
//
//  Created by Leonardo Soares on 09/10/2025.
//

import SwiftUI

struct ChoreListItemView: View {
    
    @Environment(ListingCardViewModel.self) private var listingViewModel
    
    @State private var title = ""
    @State private var description = ""
    @State private var titlePlaceholder = "Chore title"
    @State private var titleIsValid = true
    @State private var showAlert = false
    
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
                        saveAction: {
                            Task {
                                titleValidator(title)
                                await saveAction()
                            }
                        },
                        cancelAction: {
                            title = ""
                            description = ""
                            
                            withAnimation(.bouncy) {
                                choreItemType = .info(choreViewModel, isEditable: true)
                            }
                        },
                        deleteAction: {
                            withAnimation {
                                listingViewModel.removeChore(id: choreViewModel.id)
                            }
                        })
                    .onAppear {
                        title = choreViewModel.chore.title
                        description = choreViewModel.chore.description
                    }
                case .info(let choreViewModel, let isEditable):
                    ChoreInfoView(
                        choreViewModel: choreViewModel,
                        isEditable: isEditable
                    )
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
                        saveAction: {
                            Task {
                                titleValidator(title)
                                await saveAction()
                            }
                        },
                        cancelAction: {
                            title = ""
                            description = ""
                            
                            withAnimation(.bouncy) {
                                choreItemType = .add
                            }
                        })
            }
        }
        .alert(
            "You already have a chore in progress.",
            isPresented: $showAlert
        ) {
            Button(role: .cancel, action: {
                
            }, label: {
                Text("Cancel")
            })
            Button {
//                statusButtonTapped.toggle()
//                choreViewModel.changeStatus()
//                Task {
//                    await listingViewModel.pauseOnGoingChore()
//                }
            } label: {
                Text("Continue")
            }
        } message: {
            Text("If you continue, your current task will be paused for the new one take place.")
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
    case info(ChoreViewModel, isEditable: Bool = false)
    case add
    case adding
}

#Preview {
    Group {
        ChoreListItemView(
            choreItemType: .edit(
                ChoreViewModel(
                    chore: ChoreData(
                        id: UUID(),
                        status: .toDo,
                        title: "Preview",
                        description: "Preview Description"
                    )
                )
            )
        )
        
        ChoreListItemView(
            choreItemType: .info(
                ChoreViewModel(
                    chore: ChoreData(
                        id: UUID(),
                        status: .toDo,
                        title: "Preview",
                        description: "Preview Description"
                    )
                ),
                isEditable: true
            )
        )
        
        ChoreListItemView(
            choreItemType: .info(
                ChoreViewModel(
                    chore: ChoreData(
                        id: UUID(),
                        status: .toDo,
                        title: "Preview",
                        description: "Preview Description"
                    )
                )
            )
        )
        
        ChoreListItemView(
            choreItemType: .add
        )
        
        ChoreListItemView(
            choreItemType: .adding
        )
        
    }
    .environment(ListingCardViewModel(title: "Preview"))
}
