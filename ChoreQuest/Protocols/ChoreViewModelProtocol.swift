//
//  ChoreViewModelProtocol.swift
//  ChoreQuest
//
//  Created by Leonardo Soares on 10/10/2025.
//

import Foundation

protocol ChoreViewModelProtocol: Identifiable {
    var id: UUID { get }
    var chore: ChoreData { get }
    
    func setStatus(_ value: ChoreStatus)
    func changeStatus() async
    func setTitle(_ title: String)
    func setDescription(_ description: String)
}

extension ChoreViewModelProtocol {
    var isOngoingChore: Bool { chore.status != .approved || chore.status != .finished }
}
