//
//  AddChoreItemView.swift
//  ChoreQuest
//
//  Created by Leonardo Soares on 09/10/2025.
//

import SwiftUI

struct AddChoreItemView: View {
    @Environment(\.choresListCardViewModel) private var choresListCardViewModel
    
    @State private var showAlert = false
    @State private var title = ""
    @State private var description = ""
    
    @State private(set) var choreItemType: ChoreListItemType
    
    var body: some View {
        VStack {
            switch choreItemType {
                case .button:
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
                        saveAction: {
                            choresListCardViewModel.saveChore(
                                id: nil,
                                title: title,
                                description: description
                            )
                            choreItemType = .button
                        },
                        cancelAction: {
                            choreItemType = .button
                        })
                    .onAppear {
                        title = ""
                        description = ""
                    }
            }
        }
        
        // TODO: - Use this commented code on the right view
        //        .alert(
        //            "You already have a chore in progress.",
        //            isPresented: $showAlert
        //        ) {
        //            Button(role: .cancel, action: {
        //
        //            }, label: {
        //                Text("Cancel")
        //            })
        //            Button {
        ////                statusButtonTapped.toggle()
        ////                choreViewModel.changeStatus()
        ////                Task {
        ////                    await listingViewModel.pauseOnGoingChore()
        ////                }
        //            } label: {
        //                Text("Continue")
        //            }
        //        } message: {
        //            Text("If you continue, your current task will be paused for the new one take place.")
        //        }
    }
}

enum ChoreListItemType {
    case button
    case adding
}

#Preview {
    Group {
        AddChoreItemView(choreItemType: .button)
        
        AddChoreItemView(choreItemType: .adding)
    }
    .environment(\.choresListCardViewModel, ChoresListCardViewModel(title: "Preview"))
}

