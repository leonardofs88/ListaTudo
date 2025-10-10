//
//  EditListView.swift
//  ChoreQuest
//
//  Created by Leonardo Soares on 06/09/2025.
//

import SwiftUI

enum ChoreItemSelection: Identifiable {
    case newChore
    case editChore(ChoreViewModel)
    
    var id: UUID { UUID() }
}

struct EditListView: View {
    
    @Environment(\.mainViewModel) private var mainViewModel
    @Environment(\.toastViewModel) private var toastViewModel
    
    @Binding private(set) var isPresented: Bool
    
    @FocusState private var titleIsFocused
    
    @State private(set) var title: String = ""
    @State private(set) var listingViewModel: ListingCardViewModel
    //    @State private var choreItemSelection: ChoreItemSelection?
    @State private(set) var isNewList: Bool
    
    init(
        _ isPresented: Binding<Bool>,
        listingViewModel: ListingCardViewModel? = nil
    ) {
        self.isNewList = listingViewModel == nil
        self._isPresented = isPresented
        self.listingViewModel = listingViewModel ?? ListingCardViewModel(title: "")
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Add title", text: $title)
                    .focused($titleIsFocused)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                
                ChoreListItemView(choreItemType: .add)
                    .padding()
                
                ScrollView {
                    
                    VStack {
                        Text("Chore List")
                            .foregroundStyle(Color.greenFont)
                            .font(.headline)
                            .fontWeight(.bold)
                            .frame(maxWidth:.infinity, alignment: .leading)
                        ForEach(listingViewModel.choreList, id: \.chore.id) { item in
                            ChoreListItemView(choreItemType: .info(item,
                                                                   isEditable: true))
                        }
                    }
                }
                .padding()
            }
            .background(.defaultGreen.opacity(0.3))
            .toast()
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        withAnimation(.linear(duration: 0.3)) {
                            isPresented = false
                        }
                    }
                    .buttonStyle(ChoreQuestButtonStyle(padding: 8))
                }
                
                ToolbarItemGroup(placement: .bottomBar) {
                    if !isNewList {
                        Button {
                            
                        } label: {
                            HStack {
                                Image(systemName: IconNames.Objects.trash)
                                Text("Delete")
                            }
                        }
                        .buttonStyle(
                            ChoreQuestButtonStyle(
                                backgroundColor: .defaultRed
                            )
                        )
                    }
                    
                    Button {
                        Task {
                            await listValidator()
                        }
                    } label: {
                        HStack {
                            Image(systemName: IconNames.Objects.heardClipboard)
                            Text("Save")
                        }
                    }
                    .buttonStyle(ChoreQuestButtonStyle())
                }
            }
            .transition(
                .asymmetric(
                    insertion: .move(edge: .bottom),
                    removal: .move(edge: .top)
                )
            )
            .onAppear {
                title = listingViewModel.title
            }
        }
        .environment(listingViewModel)
    }
    
    @MainActor
    private func listValidator() async {
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
            await mainViewModel.saveList(
                id: listingViewModel.id,
                title: title,
                chores: listingViewModel.choreList.map({ $0.chore })
            )
            isPresented = false
        }
    }
}

#Preview {
    EditListView(.constant(true))
        .environment(MainViewModel())
        .environment(ToastViewModel())
}
