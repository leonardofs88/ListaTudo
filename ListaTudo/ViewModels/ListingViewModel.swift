//
//  ListingViewModel.swift
//  ListaTudo
//
//  Created by Leonardo Soares on 24/08/2025.
//

import Foundation

@MainActor
@Observable
class ListingViewModel: Identifiable {
    let id = UUID()
    private(set) var title: String
    private(set) var todoList: [ChoreViewModel]

    var onGoingChore: ChoreViewModel? {
        todoList.first { $0.chore.status == .inProgress }
    }
    
    init(title: String, todoList: [ChoreViewModel] = []) {
        self.title = title
        self.todoList = todoList
    }
    
    func setTitle(_ value: String) {
        title = value
    }
    
    func getListingItems() {
        todoList = ChoreData.getExampleData()
            .map({ ChoreViewModel(chore: $0) })
    }
    
    func createNewChore(_ title: String, description: String? = nil) {
        let newChore = ChoreData(
            id: UUID(),
            status: .toDo,
            title: title,
            description: description
        )
        
        todoList.append(ChoreViewModel(chore: newChore))
    }
    
    func pauseOnGoingChore() {
        todoList = todoList.map({ item in
            if item.chore.status == .inProgress {
                item.setStatus(.onPause)
            }
            return item
        })
    }
}
