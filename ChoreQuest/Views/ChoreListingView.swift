//
//  ChoreListingView.swift
//  ChoreQuest
//
//  Created by Leonardo Soares on 24/08/2025.
//

import SwiftUI

struct ChoreListingView: View {
    
    @State private(set) var title: String = ""
    @State private(set) var listingViewModel: ListingViewModel
    
    @State private var sheetIsPresented: Bool = false
    
    var body: some View {
        NavigationStack  {
            List {
                Section {
                    ForEach(listingViewModel.choreList, id: \.chore.id) { item in
                        ListItem(choreViewModel: item)
                            .environment(listingViewModel)
                    }
                } header: {
                    HStack {
                         Text(title)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                        Spacer()
                        Button {
                            sheetIsPresented = true
                        } label: {
                            Image(systemName: IconNames.Objects.pencilSquare)
                        }
                        .buttonStyle(ChoreQuestButtonStyle())
                    }
                }
            }
            .listRowSeparator(.hidden)
            .scrollContentBackground(.hidden)
            .listStyle(.plain)
            .onAppear {
                title = listingViewModel.title
                print(listingViewModel.title)
            }
            .sheet(isPresented: $sheetIsPresented) {
                EditListView(
                    sheetIsPresented: $sheetIsPresented,
                    listingViewModel: listingViewModel
                )
            }
        }
    }
}

#Preview {
    ChoreListingView(
        listingViewModel: ListingViewModel(
            title: "Household chores",
            choreList: [
                ChoreViewModel(
                    chore: ChoreData(
                        id: UUID(),
                        status: .toDo,
                        title: "Make the bed"
                    )
                ),
                ChoreViewModel(
                    chore: ChoreData(
                        id: UUID(),
                        status: .toDo,
                        title: "Do the dishes"
                    )
                ),
                ChoreViewModel(
                    chore: ChoreData(
                        id: UUID(),
                        status: .inProgress,
                        title: "Clean the wardrobe"
                    )
                ),
                ChoreViewModel(
                    chore: ChoreData(
                        id: UUID(),
                        status: .toDo,
                        title: "Put the trash out",
                        description: "Use the black bags"
                    )
                ),
                ChoreViewModel(
                    chore: ChoreData(
                        id: UUID(),
                        status: .onPause,
                        title: "Mow the lawn"
                    )
                ),
                ChoreViewModel(
                    chore: ChoreData(
                        id: UUID(),
                        status: .toDo,
                        title: "Paint the garage walls",
                        description: "Use white paint"
                    )
                ),
                ChoreViewModel(
                    chore: ChoreData(
                        id: UUID(),
                        status: .toDo,
                        title: "Fix the front door"
                    )
                ),
                ChoreViewModel(
                    chore: ChoreData(
                        id: UUID(),
                        status: .onPause,
                        title: "Replace the kitchen sink",
                        description: "Need to buy a new sink"
                    )
                ),
                ChoreViewModel(
                    chore: ChoreData(
                        id: UUID(),
                        status: .toDo,
                        title: "Buy more milk",
                        description: "Skimmed and no lactose"
                    )
                ),
                ChoreViewModel(
                    chore: ChoreData(
                        id: UUID(),
                        status: .toDo,
                        title: "Buy presents for the neighbours son",
                        description: "His birthday is on Monday"
                    )
                ),
                ChoreViewModel(
                    chore: ChoreData(
                        id: UUID(),
                        status: .toDo,
                        title: "Fix the bedroom floor"
                    )
                ),
                ChoreViewModel(
                    chore: ChoreData(
                        id: UUID(),
                        status: .toDo,
                        title: "Organize the books"
                    )
                )]
        )
    )
}
