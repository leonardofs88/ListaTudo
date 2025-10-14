//
//  EditChoreView.swift
//  GuildChores
//
//  Created by Leonardo Soares on 14/10/2025.
//

import SwiftUI

struct EditChoreView<VM: ChoreViewModelProtocol>: View {
    
    @State private(set) var choreViewModel: VM
    @State private var title: String
    @State private var description: String
    
    @Environment(\.choresListCardViewModel) var choresListCardViewModel
    
    @State var editChoreState: EditChoreState = .info
    
    init(choreViewModel: VM) {
        self.choreViewModel = choreViewModel
        self.title = choreViewModel.chore.title
        self.description = choreViewModel.chore.description
    }
    
    var body: some View {
        
        switch editChoreState {
            case .editing:
                EditChoreListItem(
                    title: $title,
                    description: $description,
                    saveAction: {
                        choresListCardViewModel.saveChore(
                            id: choreViewModel.id,
                            title: title,
                            description: description
                        )
                        editChoreState = .info
                    },
                    cancelAction: {
                        editChoreState = .info
                    },
                    deleteAction: {
                        withAnimation {
                            choresListCardViewModel.removeChore(id: choreViewModel.id)
                        }
                    })
            case .info:
                ChoreInfoView(
                    choreViewModel: choreViewModel, edit: {
                        editChoreState = .editing
                    })
        }
        
    }
}

enum EditChoreState {
    case editing
    case info
}

#Preview {
    EditChoreView(
        choreViewModel: ChoreViewModel(
            chore: ChoreData(
                id: UUID(),
                status: .onPause,
                title: "New Chore"
            )
        )
    ).environment(\.choresListCardViewModel, ChoresListCardViewModel())
}
