//
//  ChoresListCardViewModel.swift
//  ChoreQuest
//
//  Created by Leonardo Soares on 24/08/2025.
//

import Foundation

@Observable
class ChoresListCardViewModel: ChoresListCardViewModelProtocol {
    
    let id = UUID()
    private(set) var title: String
    private(set) var choreList: [ChoreViewModel]?
    
    var onGoingChore: ChoreViewModel? {
        choreList?.first { $0.chore.status == .inProgress }
    }
    
    init(title: String, choreList: [ChoreViewModel]? = nil) {
        self.title = title
        self.choreList = choreList
    }
    
    convenience init() {
        self.init(title: "")
    }
    
    func setTitle(_ value: String) {
        Task { @MainActor in
            title = value
        }
    }
    
    func setChoreList(_ list: [ChoreViewModel]) {
        Task { @MainActor in
            choreList = list
        }
    }
    
    func removeChore(id: UUID) {
        if let index = choreList?.firstIndex(where: { $0.id == id }) {
            Task { @MainActor in
                choreList?.remove(at: index)
            }
        }
    }
    
    func saveChore(id: UUID? = nil, title: String, description: String = "") {
        if let id, let index = choreList?.firstIndex(where: { $0.id == id }) {
            Task { @MainActor in
                choreList?[index].setTitle(title)
                choreList?[index].setDescription(description)
            }
        } else {
            let newChore = ChoreData(
                id: UUID(),
                status: .toDo,
                title: title,
                description: description
            )
            
            Task { @MainActor in
                if choreList == nil {
                    choreList = []
                }
                
                choreList?.append(ChoreViewModel(chore: newChore))
            }
        }
    }
    
    func pauseOnGoingChore() {
        Task { @MainActor in
            choreList = choreList?.map({ item in
                if item.chore.status == .inProgress {
                    item.setStatus(.onPause)
                }
                return item
            })
        }
    }
}
