//
//  MainViewModelProtocol.swift
//  ChoreQuest
//
//  Created by Leonardo Soares on 07/10/2025.
//

import Foundation
import SwiftUI

protocol MainViewModelProtocol: Observable {
    var lists: [ListingCardViewModel] { get }
    
    func saveList(id: UUID?, title: String, chores: [ChoreData]) async
    func getLists() async
}

struct MainViewModelKey: EnvironmentKey {
    static let defaultValue: any MainViewModelProtocol = MainViewModel()
}

extension EnvironmentValues {
    var mainViewModel: any MainViewModelProtocol {
        get { self[MainViewModelKey.self] }
        set { self[MainViewModelKey.self] = newValue }
    }
}
