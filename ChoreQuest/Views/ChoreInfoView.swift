//
//  ChoreInfoView.swift
//  ChoreQuest
//
//  Created by Leonardo Soares on 10/10/2025.
//

import SwiftUI

struct ChoreInfoView: View {
    
    @State var choreViewModel: ChoreViewModel
    var isEditable: Bool
    
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
                    Task {
                        await choreViewModel.changeStatus()
                        print(("icon: ", choreViewModel.chore.status.icon(), " color: ", choreViewModel.chore.status.color()))
                    }
//                            }
//                        }
                } label: {
                    Image(systemName: choreViewModel.chore.status.icon())
                }
                .frame(width: 40, height: 40)
                .buttonStyle(ChoreQuestButtonStyle(backgroundColor: choreViewModel.chore.status.color()))
                
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
