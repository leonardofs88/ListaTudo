//
//  ChoreData.swift
//  ListaTudo
//
//  Created by Leonardo Soares on 24/08/2025.
//

import Foundation

struct ChoreData: Identifiable, Codable, Hashable {
    var id: UUID
    var status: ChoreStatus
    var title: String
    var description: String?
    
   static func getExampleData() -> [ChoreData] {
        [ChoreData(
            id: UUID(),
            status: .inProgress,
            title: "Do the dishes",
            description: "Need to use good soap"
        ),
         ChoreData(
            id: UUID(),
            status: .toDo,
            title: "Broom the living room",
            description: "Don't use the outside broom"
         ),
         ChoreData(
            id: UUID(),
            status: .approved,
            title: "Brush the bathtub",
         ),
         ChoreData(
            id: UUID(),
            status: .toDo,
            title: "Throw the garbage",
            description: "Please, recycle"
         ),
         ChoreData(
            id: UUID(),
            status: .finished,
            title: "Prepare diner",
            description: "today we'll get a good pasta"
         ),
         ChoreData(
            id: UUID(),
            status: .approved,
            title: "Repair the shoe rack",
            description: "It's almost breaking"
         ),
         ChoreData(
            id: UUID(),
            status: .toDo,
            title: "Broom the living room",
            description: "Don't use the outside broom"
         ),
         ChoreData(
            id: UUID(),
            status: .toDo,
            title: "Broom the living room",
            description: "Don't use the outside broom"
         )]
    }
}
