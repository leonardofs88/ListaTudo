//
//  ChoreInfoView.swift
//  ChoreQuest
//
//  Created by Leonardo Soares on 10/10/2025.
//

import SwiftUI

struct ChoreInfoView<VM: ChoreViewModelProtocol>: View {
    
    private(set) var choreViewModel: VM
    private(set) var action: (() -> Void)?
    private(set) var edit: (() -> Void)?
    
    @State private var tapped = false
    
    init(
        choreViewModel: VM,
        action: (() -> Void)? = nil,
        edit: (() -> Void)? = nil)
    {
        self.choreViewModel = choreViewModel
        self.action = action
        self.edit = edit
    }
    
    var body: some View {
        HStack {
            Button {
                if let action {
                    tapped = true
                    withAnimation(.bouncy) {
                        tapped = false
                    }
                    
                    Task {
                        await choreViewModel.changeStatus()
                        action()
                    }
                }
            } label: {
                Image(systemName: choreViewModel.chore.status.icon())
                    .font(.system(size: 17, weight: .semibold))
                    .padding(12)
                    .foregroundStyle(.white)
            }
            .scaleEffect(tapped ? 0.9 : 1)
            .background(
                choreViewModel.chore.status.color()
                    .clipShape(
                        Circle()
                    )
            )
            .shadow(
                color: choreViewModel.chore.status.color().opacity(0.7),
                radius: 0,
                x: tapped ? 1 : 3,
                y: tapped ? 1 : 3
            )
            
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
            
            if let edit {
                Button {
                    withAnimation(.bouncy) {
                        edit()
                    }
                } label: {
                    Image(systemName: IconNames.Objects.pencilSquare)
                }
                .buttonStyle(ChoreQuestButtonStyle(padding: 12, backgroundColor: .greenFont))
            }
            
        }
        .foregroundStyle(.greenFont)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.defaultGreen)
                .shadow(color: .gray, radius: 2, x: 0, y: 2)
        )
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    ChoreInfoView(
        choreViewModel: ChoreViewModel(chore: ChoreData(id: UUID(), status: .toDo, title: "Title")),
        action: {
            // TODO: Use this commented code on the correct view
            //                    if choreViewModel.chore.status != .approved,
            //                           choreViewModel.chore.status != .finished {
            //                            if listingViewModel.onGoingChore != nil,
            //                               listingViewModel.onGoingChore?.id != choreViewModel.id {
            ////                                       showAlert = true
            //                            } else {
            ////                                        statusButtonTapped.toggle()
            print("Change chore status button tapped")
        })
    
    ChoreInfoView(
        choreViewModel: ChoreViewModel(chore: ChoreData(id: UUID(), status: .toDo, title: "Title")),
        edit: {
            print("Edit mode")
        })
}
