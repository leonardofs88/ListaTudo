//
//  ContentView.swift
//  ListaTudo
//
//  Created by Leonardo Soares on 17/08/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ListingView(
            listingViewModel: ListingViewModel()
        )
    }
}

#Preview {
    ContentView()
}

struct ListingView: View {
    @State private(set) var listingViewModel: ListingViewModel
    
    var body: some View {
        List(listingViewModel.todoList) { item in
           ListItem(item: item)
        }
        .onAppear {
            listingViewModel.getListingItems()
        }
    }
}

@MainActor
@Observable
class ChoreViewModel {
    private(set) var chore: ChoreData
    
    init(chore: ChoreData) {
        self.chore = chore
    }
    
    func setStatus(_ value: Bool) {
        chore.status = value
    }
    
    func setDescription(_ description: String) {
        chore.description = description
    }
}

@MainActor
@Observable
class ListingViewModel {
    private(set) var todoList: [ChoreData] = []
    
    func getListingItems() {
        todoList = ChoreData.getExampleData()
    }
    
    func createNewChore(_ title: String, description: String? = nil) {
        let newChore = ChoreData(
            status: false,
            title: title,
            description: description
        )
        
        todoList.append(newChore)
    }
}

struct ListItem: View {
    
    @State private(set) var item: ChoreData
    @State private var circleSize: CGFloat = 15
    @State private var circleColor = Color.secondary
    
    var body: some View {
        VStack {
            HStack {
                Circle()
                    .fill(circleColor)
                    .frame(width: circleSize, height: circleSize)
                    .scaleEffect(item.status ? 1 : 0.5)
                    .animation(
                        .easeOut(duration: 0.2),
                        value: item.status
                    )
                    .onTapGesture {
                        item.status.toggle()
                        configButton()
                    }
                
                VStack(alignment: .leading) {
                    Text(item.title)
                        .font(.headline)
                    
                    if let description = item.description {
                        Text(description)
                            .font(.subheadline)
                    }
                }
            }
        }
        .onAppear {
            configButton()
        }
    }
    
    private func configButton() {
        circleColor = item.status ? Color.green : Color.yellow
        circleSize = item.status ? 17 : 15
    }
}

struct ListingData: Identifiable {
    let id = UUID()
    var name: String
    var chores: [ChoreData]
}

struct ChoreData: Identifiable {
    let id = UUID()
    var status: Bool
    var title: String
    var description: String?
    
   static func getExampleData() -> [ChoreData] {
        [ChoreData(
            status: false,
            title: "Do the dishes",
            description: "Need to use good soap"
        ),
         ChoreData(
            status: false,
            title: "Broom the living room",
            description: "Don't use the outside broom"
         ),
         ChoreData(
            status: true,
            title: "Brush the bathtub",
         ),
         ChoreData(
            status: false,
            title: "Throw the garbage",
            description: "Please, recycle"
         ),
         ChoreData(
            status: true,
            title: "Prepare diner",
            description: "today we'll get a good pasta"
         ),
         ChoreData(
            status: false,
            title: "Repair the shoe rack",
            description: "It's almost breaking"
         ),
         ChoreData(
            status: false,
            title: "Broom the living room",
            description: "Don't use the outside broom"
         ),
         ChoreData(
            status: false,
            title: "Broom the living room",
            description: "Don't use the outside broom"
         )]
    }
}
