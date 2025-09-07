//
//  MainViewModel.swift
//  ListaTudo
//
//  Created by Leonardo Soares on 06/09/2025.
//

import SwiftUI

@MainActor
@Observable
class MainViewModel {
    private(set) var lists: [ListingViewModel] = []
    
    func createNewList(title: String, chores: [ChoreData]) {
        let viewModels = chores.map { ChoreViewModel(chore: $0) }
        let newList = ListingViewModel(title: title, todoList: viewModels)
        lists.append(newList)
    }
    
    func addList(_ list: ListingViewModel) {
        lists.append(list)
    }
    
    func getLists() {
    }
}
