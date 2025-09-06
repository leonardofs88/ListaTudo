//
//  ListingView.swift
//  ListaTudo
//
//  Created by Leonardo Soares on 24/08/2025.
//

import SwiftUI

struct ListingView: View {
    @State private(set) var listingViewModel: ListingViewModel
    
    var body: some View {
        NavigationStack  {
            List(listingViewModel.todoList, id: \.chore.id) { item in
                ListItem(choreViewModel: item)
                    .environment(listingViewModel)
            }
            .listStyle(.plain)
            .navigationTitle(listingViewModel.title)
            .onAppear {
                listingViewModel.getListingItems()
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
