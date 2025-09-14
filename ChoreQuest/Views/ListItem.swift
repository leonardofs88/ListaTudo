//
//  ListItem.swift
//  ChoreQuest
//
//  Created by Leonardo Soares on 24/08/2025.
//

import SwiftUI

struct ListItem: View {
    
    @Environment(ChoreListingViewModel.self) private var listingViewModel
    @State private(set) var choreViewModel: ChoreViewModel
    @State private var circleSize: CGFloat = 15
    @State private var circleColor = Color.secondary
    @State private var statusButtonTapped = false
    @State private var showAlert = false
    
    var body: some View {
        VStack {
            HStack {
                HStack(alignment: .center) {
                    Image(systemName: choreViewModel.chore.status.icon())
                        .resizable()
                        .frame(width: circleSize, height: circleSize)
                        .foregroundStyle(choreViewModel.chore.status.color())
                        .animation(
                            .spring(duration: 0.2,bounce: 0.7),
                            value: statusButtonTapped
                        )
                        .onTapGesture {
                            if choreViewModel.chore.status != .approved,
                               choreViewModel.chore.status != .finished {
                                if listingViewModel.onGoingChore != nil,
                                   listingViewModel.onGoingChore?.id != choreViewModel.id{
                                   showAlert = true
                                } else {
                                    statusButtonTapped.toggle()
                                    choreViewModel.changeStatus()
                                }
                            }
                        }
                }
                .frame(width: 20, height: 20)
                
                VStack(alignment: .leading) {
                    Text(choreViewModel.chore.title)
                        .font(.headline)
                        .strikethrough(choreViewModel.chore.status == .approved)
                    
                    if !choreViewModel.chore.description.isEmpty {
                        Text(choreViewModel.chore.description)
                            .font(.subheadline)
                    }
                }
            }
        }
        .onAppear {
            circleSize = choreViewModel.chore.status == .approved ? 18 : 15
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
                statusButtonTapped.toggle()
                listingViewModel.pauseOnGoingChore()
                choreViewModel.changeStatus()
            } label: {
                Text("Continue")
            }
        } message: {
            Text("If you continue, your current task will be paused for the new one take place.")
        }

    }
}

#Preview {
    ListItem(
        choreViewModel: ChoreViewModel(
            chore: ChoreData(id: UUID(), status: .approved, title: "Aparate")
        )
    )
    .environment(ChoreListingViewModel(title: "Asss"))
}
