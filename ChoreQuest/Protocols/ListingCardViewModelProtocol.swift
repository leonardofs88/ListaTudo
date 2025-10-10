//
//  ListingCardViewModelProtocol.swift
//  ChoreQuest
//
//  Created by Leonardo Soares on 10/10/2025.
//

import Foundation

@MainActor
protocol ListingCardViewModelProtocol: Identifiable {
    var id: UUID { get }
    var title: String { get }
    var choreList: [ChoreViewModel] { get }
    var onGoingChore: ChoreViewModel?  { get }
    func setTitle(_ value: String)
    func setChoreList(_ list: [ChoreViewModel])
    func removeChore(id: UUID)
    func saveChore(id: UUID?, title: String, description: String) async
    func pauseOnGoingChore() async
}
