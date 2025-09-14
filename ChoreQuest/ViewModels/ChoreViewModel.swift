//
//  ChoreViewModel.swift
//  ChoreQuest
//
//  Created by Leonardo Soares on 24/08/2025.
//

import Foundation

@MainActor
@Observable
class ChoreViewModel: Identifiable {
    let id: UUID
    private(set) var chore: ChoreData
    init(chore: ChoreData) {
        self.chore = chore
        self.id = chore.id
    }
    
    func setStatus(_ value: ChoreStatus) {
        chore.status = value
    }
    
    func changeStatus() {
        chore.status = switch chore.status {
        case .toDo, .onPause:
                .inProgress
        case .inProgress:
                .onPause
        default:
            chore.status
        }
    }
    
    func setTitle(_ title: String) {
        chore.title = title
    }
    
    func setDescription(_ description: String) {
        chore.description = description
    }
}
