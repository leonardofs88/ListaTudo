//
//  ChoreViewModelProtocol.swift
//  ChoreQuest
//
//  Created by Leonardo Soares on 10/10/2025.
//

import Foundation

@MainActor
protocol ChoreViewModelProtocol: Identifiable {
    var id: UUID { get }
    var chore: ChoreData { get }
    
    func setStatus(_ value: ChoreStatus)
    func changeStatus() async
    func setTitle(_ title: String)
    func setDescription(_ description: String)
}
