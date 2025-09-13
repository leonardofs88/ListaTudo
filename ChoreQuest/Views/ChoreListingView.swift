//
//  ChoreListingView.swift
//  ChoreQuest
//
//  Created by Leonardo Soares on 24/08/2025.
//

import SwiftUI

struct ChoreListingView: View {
    @FocusState private var titleIsFocused
    
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
                         TextField("New Chore List Title", text: $title)
                                .focused($titleIsFocused)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                        Spacer()
                        Button {
                            sheetIsPresented = true
                        } label: {
                            Image(systemName: IconNames.Objects.pencilSquare)
                        }
                        .buttonStyle(BlueButton())
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .listStyle(.plain)
            .onChange(of: titleIsFocused, { oldValue, newValue in
                listingViewModel.setTitle(title)
            })
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
            title: "Aaaa"
        )
    )
}
