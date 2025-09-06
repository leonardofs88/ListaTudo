//
//  ContentView.swift
//  ListaTudo
//
//  Created by Leonardo Soares on 17/08/2025.
//

import SwiftUI

struct ContentView: View {
    
    @State private(set) var mainViewModel = MainViewModel()
    @State private var currentIndex: Int = 0
    
    var body: some View {
        /**
         Cards view styling adapted from: https://medium.com/@kusalprabathrajapaksha/animated-carousel-view-swiftui-cee1954f0be7
         */
        GeometryReader { proxy in
            ScrollView(.horizontal) {
                LazyHStack(spacing: 5) {
                    ForEach(Array(mainViewModel.lists.enumerated()), id: \.offset) {
                        index,
                        item in
                        ListingView(listingViewModel: item)
                            .frame(
                                width: proxy.size.width * 0.94,
                                height:proxy.size.height * 0.94,
                                alignment: .leading
                            )
                    }
                    .clipShape(.rect(cornerRadius: 20.0))
                }
                .shadow(radius: 5, x: 5, y: 5)
                .scrollTargetLayout() // Align content to the view
            }
        }
        .contentMargins(10, for: .scrollContent)
        .scrollTargetBehavior(.paging) // Align content behavior
        .background(Color.yellow)
        .onAppear(perform: {
            mainViewModel.getLists()
        })
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                Button {
                    
                } label: {
                    HStack {
                        Text("Create a new List")
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

@MainActor
@Observable
class MainViewModel {
    private(set) var lists: [ListingViewModel] = []
    
    func createNewList(title: String, chores: [ChoreData]) {
        let viewModels = chores.map { ChoreViewModel(chore: $0) }
        let newList = ListingViewModel(title: title, todoList: viewModels)
        lists.append(newList)
    }
    
    func getLists() {
        let newList = ListingViewModel(title: "Hello")
        lists.append(newList)
        let newList1 = ListingViewModel(title: "dey")
        lists.append(newList1)
        let newList2 = ListingViewModel(title: "212")
        lists.append(newList2)
        let newList3 = ListingViewModel(title: "566655")
        lists.append(newList3)
    }
    
    func getNextId(_ viewModel: ListingViewModel) -> Int {
        let index = lists.firstIndex { $0.id == viewModel.id } ?? 0
        return index + 1
    }
}
