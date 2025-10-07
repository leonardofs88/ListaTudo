//
//  MainViewModel.swift
//  ChoreQuest
//
//  Created by Leonardo Soares on 06/09/2025.
//

import SwiftUI

@Observable
class MainViewModel: MainViewModelProtocol {
    
    private(set) var lists: [ChoreListingViewModel] = []
    
    @MainActor
    func saveList(id: UUID? = nil, title: String, chores: [ChoreData]) async {
        if let id, let index = lists.firstIndex(where: { $0.id == id }) {
            lists[index].setTitle(title)
            chores.lazy.forEach { chore in
                lists[index].saveChore(
                    id: chore.id,
                    title: chore.title,
                    description: chore.description
                )
            }
        } else {
            let viewModels = chores.map { ChoreViewModel(chore: $0) }
            let newList = ChoreListingViewModel(
                title: title,
                choreList: viewModels
            )
            lists.append(newList)
        }
    }
    
    @MainActor
    func getLists() async {
    }
}
