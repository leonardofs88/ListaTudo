//
//  ChoreViewModel.swift
//  ChoreQuest
//
//  Created by Leonardo Soares on 24/08/2025.
//

import Foundation
import SwiftUI

@Observable
class ChoreViewModel: ChoreViewModelProtocol {
    let id: UUID
    private(set) var chore: ChoreData
    
    init(chore: ChoreData) {
        self.chore = chore
        self.id = chore.id
    }
    
    func setStatus(_ value: ChoreStatus) {
        chore.status = value
    }
    
    func changeStatus() async {
        self.chore.status = switch chore.status {
            case .toDo, .onPause:
                    .inProgress
            case .inProgress:
                    .onPause
            default:
                self.chore.status
        }
    }
    
    func setTitle(_ title: String) {
        chore.title = title
    }
    
    func setDescription(_ description: String) {
        chore.description = description
    }
}

struct ChoreViewModelKey: EnvironmentKey {
    static let defaultValue: (any ChoreViewModelProtocol)? = nil
}

extension EnvironmentValues {
    var choreViewModel: (any ChoreViewModelProtocol)? {
        get { self[ChoreViewModelKey.self] }
        set { self[ChoreViewModelKey.self] = newValue }
    }
}
