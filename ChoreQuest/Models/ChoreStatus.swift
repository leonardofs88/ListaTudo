//
//  ChoreStatus.swift
//  ChoreQuest
//
//  Created by Leonardo Soares on 24/08/2025.
//

import Foundation
import SwiftUI

enum ChoreStatus: Codable {
    case toDo
    case inProgress
    case onPause
    case finished
    case approved
    
    func color() -> Color {
        switch self {
        case .toDo:
            Color.secondary
        case .onPause:
            Color.blue
        case .inProgress:
            Color.orange
        case .finished:
            Color.red
        case .approved:
            Color.green
        }
    }
    
    func icon() -> String {
        switch self {
        case .toDo, .onPause:
            IconNames.Control.play
        case .inProgress:
            IconNames.Control.pause
        case .finished:
            IconNames.Control.stop
        case .approved:
            IconNames.Status.check
        }
    }
}
