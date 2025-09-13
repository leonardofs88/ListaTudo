//
//  EditListView.swift
//  ChoreQuest
//
//  Created by Leonardo Soares on 06/09/2025.
//

import SwiftUI

struct EditListView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(MainViewModel.self) private var mainViewModel
    @Environment(ToastViewModel.self) private var toastViewModel
    @Binding private(set) var sheetIsPresented: Bool
    @FocusState private var titleIsFocused
    @State private(set) var title: String = ""
    @State private(set) var listingViewModel: ListingViewModel
    @State private var selectedChore: ChoreViewModel?
    @State private var isEditChoreShowing = false
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section {
                        Section {
                            Button {
                                selectedChore = nil
                                isEditChoreShowing = true
                            } label: {
                                Label("Add chore", systemImage: IconNames.Control.plus)
                            }
                        }
                        
                        ForEach(listingViewModel.choreList, id: \.chore.id) { item in
                            Section {
                                VStack(alignment: .leading) {
                                    Text(item.chore.title)
                                    if !item.chore.description.isEmpty {
                                        Text(item.chore.description)
                                            .font(.subheadline)
                                    }
                                }
                                .swipeActions {
                                    Button {
                                        selectedChore = item
                                        isEditChoreShowing = true
                                    } label: {
                                        Image(systemName: IconNames.Objects.pencilSquare)
                                    }.tint(.purple)
                                }
                            }
                        }
                    } header: {
                        TextField("Add title", text: $title)
                            .focused($titleIsFocused)
                            .font(.title)
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
            .sheet(isPresented: $isEditChoreShowing, content: {
                ChoreItemView(choreViewModel: selectedChore)
                    .environment(listingViewModel)
            })
            .toast(viewModel: toastViewModel)
            .background(Color.yellow.opacity(0.5))
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .buttonStyle(BlueButton(padding: 8))
                }
            }
        }
    }
    
    private func listValidator() {
        if listingViewModel.choreList.isEmpty || title.isEmpty {
            toastViewModel.setToast(
                ToastData(
                    style: .alert,
                    message: "List needs a title and content",
                    duration: 3
                )
            )
            toastViewModel.showToast()
        } else {
            listingViewModel.setTitle(title)
            mainViewModel.addList(listingViewModel)
            sheetIsPresented = false
        }
    }
}

#Preview {
    EditListView(
        sheetIsPresented: .constant(true),
        listingViewModel: ListingViewModel(title: "")
    )
    .environment(MainViewModel())
    .environment(ToastViewModel())
}
