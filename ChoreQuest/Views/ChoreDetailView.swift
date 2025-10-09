//
//  ChoreDetailView.swift
//  ChoreQuest
//
//  Created by Leonardo Soares on 08/10/2025.
//

import SwiftUI

struct ChoreDetailView: View {
    private(set) var title: String
    private(set) var description: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .fontWeight(.bold)
            
            Text(description)
                .font(.subheadline)
                .fontWeight(.bold)
        }
        .padding()
        .foregroundStyle(Color.white)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.defaultGreen))
                .shadow(color: .gray, radius: 2, x: 0, y: 2)
        )
    }
}

#Preview {
    ChoreDetailView(title: "Chore Title", description: "Chore name")
}
