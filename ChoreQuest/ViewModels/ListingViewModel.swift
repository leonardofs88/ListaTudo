//
//  ListingViewModel.swift
//  ChoreQuest
//
//  Created by Leonardo Soares on 24/08/2025.
//

import Foundation

@MainActor
@Observable
class ListingViewModel: Identifiable {
    let id = UUID()
    private(set) var title: String
    private(set) var choreList: [ChoreViewModel]

    var onGoingChore: ChoreViewModel? {
        choreList.first { $0.chore.status == .inProgress }
    }
    
    init(title: String, choreList: [ChoreViewModel] = []) {
        self.title = title
        self.choreList = choreList
    }
    
    func setTitle(_ value: String) {
        title = value
    }
    
    func setChoreList(_ list: [ChoreViewModel]) {
        choreList = list
    }

    func saveChore(id: UUID? = nil, title: String, description: String = "") {
        if let id, let index = choreList.firstIndex(where: { $0.id == id }) {
            choreList[index].setTitle(title)
            choreList[index].setDescription(description)
        } else {
            let newChore = ChoreData(
                id: UUID(),
                status: .toDo,
                title: title,
                description: description
            )
            
            choreList.append(ChoreViewModel(chore: newChore))
        }
    }
    
    func pauseOnGoingChore() {
        choreList = choreList.map({ item in
            if item.chore.status == .inProgress {
                item.setStatus(.onPause)
            }
            return item
        })
    }
}
