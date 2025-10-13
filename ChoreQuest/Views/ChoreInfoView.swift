//
//  ChoreInfoView.swift
//  ChoreQuest
//
//  Created by Leonardo Soares on 10/10/2025.
//

import SwiftUI

struct ChoreInfoView: View {
    
    private(set) var choreViewModel: ChoreViewModel
    private(set) var isEditable: Bool
    
    @State private var tapped = false
    
    var body: some View {
            HStack {
                Button {
//                    if choreViewModel.chore.status != .approved,
//                           choreViewModel.chore.status != .finished {
//                            if listingViewModel.onGoingChore != nil,
//                               listingViewModel.onGoingChore?.id != choreViewModel.id {
////                                       showAlert = true
//                            } else {
////                                        statusButtonTapped.toggle()
                    tapped = true
                    withAnimation {
                        tapped = false
                    }
                    
                    Task {
                        await choreViewModel.changeStatus()
                    }
                } label: {
                    Image(systemName: choreViewModel.chore.status.icon())
                }
                .frame(width: 40, height: 40)
                .foregroundStyle(Color.white)
                .background(choreViewModel.chore.status.color())
                .clipShape(Circle())
                .scaleEffect(tapped ? 1.3 : 1)
                
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
                
                if isEditable {
                    Button {
                        withAnimation(.bouncy) {
                            
                        }
                    } label: {
                        Image(systemName: IconNames.Objects.pencilSquare)
                    }
                    .buttonStyle(ChoreQuestButtonStyle(backgroundColor: .greenFont))
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
        isEditable: true
    )
    
    ChoreInfoView(
        choreViewModel: ChoreViewModel(chore: ChoreData(id: UUID(), status: .toDo, title: "Title")),
        isEditable: false
    )
}
