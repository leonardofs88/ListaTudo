//
//  ListingView.swift
//  ListaTudo
//
//  Created by Leonardo Soares on 24/08/2025.
//

import SwiftUI

struct ListingView: View {
    @FocusState private var titleIsFocused
    
    @State private(set) var title: String = ""
    @State private(set) var listingViewModel: ListingViewModel
    
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
                         TextField("Title", text: $title)
                                .focused($titleIsFocused)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                        Spacer()
                        Button {
                            
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
        }
    }
}

#Preview {
    ListingView(
        listingViewModel: ListingViewModel(
            title: "Aaaa"
        )
    )
}
