//
//  NewListView.swift
//  ListaTudo
//
//  Created by Leonardo Soares on 06/09/2025.
//

import SwiftUI

struct NewListView: View {
    @Environment(MainViewModel.self) private var mainViewModel
    @Binding private(set) var sheetIsPresented: Bool
    @FocusState private var titleIsFocused
    @State private(set) var title: String = ""
    @State private var listingViewModel: ListingViewModel = ListingViewModel(title: "")
    
    var body: some View {
        VStack {
            List {
                Section {
                    NewChoreItemView()
                        .environment(listingViewModel)
                        .transition(
                            .push(from: .top)
                            .combined(with: .opacity)
                        )
                    
                    ForEach(listingViewModel.choreList, id: \.chore.id) { item in
                        VStack(alignment: .leading) {
                            Text(item.chore.title)
                                .font(.headline)
                            if !item.chore.description.isEmpty {
                                Text(item.chore.description)
                                    .font(.subheadline)
                            }
                        }
                    }
                } header: {
                    TextField("New List", text: $title)
                        .focused($titleIsFocused)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
            }
            .scrollContentBackground(.hidden)
            
            Button {
                listValidator()
            } label: {
                HStack {
                    Image(systemName: IconNames.Objects.heardClipboard)
                    Text("Save list")
                }
            }
            .buttonStyle(BlueButton())
        }
        .background(Color.yellow.opacity(0.5))
    }
    
    private func listValidator() {
        if !(listingViewModel.choreList.isEmpty || listingViewModel.title.isEmpty) {
            
        } else {
            listingViewModel.setTitle(title)
            mainViewModel.addList(listingViewModel)
            sheetIsPresented = false
        }
    }
}

#Preview {
    NewListView(sheetIsPresented: .constant(true))
        .environment(MainViewModel())
}
