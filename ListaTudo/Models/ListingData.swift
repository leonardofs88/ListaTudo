//
//  ListingData.swift
//  ListaTudo
//
//  Created by Leonardo Soares on 24/08/2025.
//

import Foundation

struct ListingData: Identifiable {
    let id = UUID()
    var name: String
    var chores: [ChoreData]
}
