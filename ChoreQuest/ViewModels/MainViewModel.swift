//
//  MainViewModel.swift
//  ChoreQuest
//
//  Created by Leonardo Soares on 06/09/2025.
//

import SwiftUI

@MainActor
@Observable
class MainViewModel {
    private(set) var lists: [ListingViewModel] = []
    
    func saveList(id: UUID? = nil, title: String, chores: [ChoreData]) {
        if let id, let index = lists.firstIndex(where: { $0.id == id }) {
            lists[index].setTitle(title)
            chores.forEach { chore in
                lists[index].saveChore(
                    id: chore.id,
                    title: chore.title,
                    description: chore.description
                )
            }
            
        } else {
            let viewModels = chores.map { ChoreViewModel(chore: $0) }
            let newList = ListingViewModel(
                title: title,
                choreList: viewModels
            )
            lists.append(newList)
        }
    }
    
    
    func getLists() {
    }
}
