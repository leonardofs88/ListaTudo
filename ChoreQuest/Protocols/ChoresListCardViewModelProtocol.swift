//
//  ChoresListCardViewModelProtocol.swift
//  ChoreQuest
//
//  Created by Leonardo Soares on 10/10/2025.
//

import Foundation
import SwiftUI

protocol ChoresListCardViewModelProtocol: Identifiable {
    var id: UUID { get }
    var title: String { get }
    var choreList: [ChoreViewModel]? { get }
    var onGoingChore: ChoreViewModel?  { get }
    func setTitle(_ value: String)
    func setChoreList(_ list: [ChoreViewModel])
    func removeChore(id: UUID)
    func saveChore(id: UUID?, title: String, description: String)
    func pauseOnGoingChore()
}

// TODO: - Change to use Factory
struct ChoresListCardViewModelKey: EnvironmentKey {
    static let defaultValue: any ChoresListCardViewModelProtocol = ChoresListCardViewModel()
}

extension EnvironmentValues {
    var choresListCardViewModel: any ChoresListCardViewModelProtocol {
        get { self[ChoresListCardViewModelKey.self] }
        set { self[ChoresListCardViewModelKey.self] = newValue }
    }
}
