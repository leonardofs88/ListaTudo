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

struct EditListView<VM: ChoresListCardViewModelProtocol>: View {
    
    @Environment(\.mainViewModel) private var mainViewModel
    @Environment(\.toastViewModel) private var toastViewModel
    
    @FocusState private var titleIsFocused
    
    @State private(set) var title: String = ""
    
    @Binding private(set) var isPresented: Bool
    
    @State private(set) var choresListCardViewModel: VM
    
    var isNewList: Bool
    
    init(
        _ isPresented: Binding<Bool>,
        isNewList: Bool = true,
        choresCardViewModel: VM
    ) {
        self._isPresented = isPresented
        self.choresListCardViewModel = choresCardViewModel
        self.isNewList = isNewList
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Add title", text: $title)
                    .focused($titleIsFocused)
                    .font(.title)
                    .fontWeight(.bold)
                
                AddChoreItemView(choreItemType: .button)
                
                if let list = choresListCardViewModel.choreList {
                    ScrollView {
                        VStack {
                            Text("Chore List")
                                .foregroundStyle(Color.greenFont)
                                .font(.headline)
                                .fontWeight(.bold)
                                .frame(maxWidth:.infinity, alignment: .leading)
                            ForEach(list, id: \.chore.id) { item in
                                EditChoreView(choreViewModel: item)
                            }
                        }
                    }
                }
                else {
                    Spacer()
                }
            }
            .padding()
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
                title = choresListCardViewModel.title
            }
        }
        .environment(\.choresListCardViewModel, choresListCardViewModel)
    }
    
    @MainActor
    private func listValidator() async {
        guard let list = choresListCardViewModel.choreList else { return }
        if list.isEmpty || title.isEmpty {
            toastViewModel.setToast(
                ToastData(
                    style: .alert,
                    message: "List needs a title and content",
                    duration: 3
                )
            )
            toastViewModel.showToast()
        } else {
            choresListCardViewModel.setTitle(title)
            mainViewModel.saveList(
                id: choresListCardViewModel.id,
                title: title,
                chores: list.map({ $0.chore })
            )
            isPresented = false
        }
    }
}

#Preview {
    EditListView(.constant(true),
                 choresCardViewModel: ChoresListCardViewModel())
    .environment(MainViewModel())
    .environment(ToastViewModel())
}
