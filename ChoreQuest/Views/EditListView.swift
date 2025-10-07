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
    
    @Namespace var animation
    
    @Environment(\.mainViewModel) private var mainViewModel
    @Environment(\.toastViewModel) private var toastViewModel
    
    @Binding private(set) var isPresented: Bool
    
    @FocusState private var titleIsFocused
    
    @State private(set) var title: String = ""
    @State private(set) var listingViewModel: ChoreListingViewModel
    @State private var choreItemSelection: ChoreItemSelection?
    @State private(set) var showNewChore: Bool = false
    @State private(set) var isNewList: Bool
    
    init(
        _ isPresented: Binding<Bool>,
        listingViewModel: ChoreListingViewModel? = nil
    ) {
        self.isNewList = listingViewModel == nil
        self._isPresented = isPresented
        self.listingViewModel = listingViewModel ?? ChoreListingViewModel(title: "")
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                        if showNewChore {
                            ChoreItemView(isPresented: $showNewChore, animation: animation)
                                .environment(listingViewModel)
                        } else {
                            Button {
                                withAnimation(.spring(.snappy, blendDuration: 0.3)) {
                                    showNewChore.toggle()
                                }
                            } label: {
                                Label("Add chore", systemImage: IconNames.Control.plus)
                            }
                            .transition(.move(edge: .bottom))
                            .matchedGeometryEffect(
                                id: "addChore",
                                in: animation,
                                properties: .size,
                                isSource: false
                            )
                        }
                    
                    Section {
                        ForEach(listingViewModel.choreList, id: \.chore.id) { item in
                            VStack(alignment: .leading) {
                                Text(item.chore.title)
                                if !item.chore.description.isEmpty {
                                    Text(item.chore.description)
                                        .font(.subheadline)
                                }
                            }
                            .swipeActions {
                                Button {
                                    choreItemSelection = .editChore(item)
                                } label: {
                                    Image(systemName: IconNames.Objects.pencilSquare)
                                }.tint(.purple)
                            }
                        }
                    }
                } header: {
                    HStack {
                        TextField("Add title", text: $title)
                            .focused($titleIsFocused)
                            .font(.title)
                            .fontWeight(.bold)
                    }
                }
            }
            .scrollContentBackground(.hidden)
            //            .sheet(item: $choreItemSelection) { selection in
            //                let viewModel: ChoreViewModel? = switch selection {
            //                    case .newChore:
            //                        nil
            //                    case .editChore(let editViewModel):
            //                        editViewModel
            //                }
            //
            //                ChoreItemView(choreViewModel: viewModel, isPresented: $showNewChore)
            //                    .environment(listingViewModel)
            //            }
            .toast()
            .background(Color.yellow.opacity(0.5))
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
                                backgroundColor: ColorNames.defaultRed
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
    }
    
    @MainActor
    private func listValidator() async{
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
