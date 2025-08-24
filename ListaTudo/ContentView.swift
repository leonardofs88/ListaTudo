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
        HStack {
            VStack(alignment: .center) {
                GeometryReader { proxy in
                    ZStack {
                        ForEach(Array(mainViewModel.lists.enumerated()), id: \.offset) { index, item in
                            ZStack {
                                ListingView(listingViewModel: item)
                            }
                            .offset(x: CGFloat(index - currentIndex) * (proxy.size.width * 0.93))
                        }
                    }
                    .gesture(
                        DragGesture()
                            .onEnded { value in
                                let cardWidth = proxy.size.width * 0.2
                                let offset = value.translation.width / cardWidth
                                
                                withAnimation(.spring) {
                                    if value.translation.width < -offset {
                                        currentIndex = min(currentIndex + 1, mainViewModel.lists.count - 1)
                                    } else if value.translation.width > offset {
                                        currentIndex = max(currentIndex - 1, 0)
                                    }
                                }
                            }
                    )
                }
            }
            .padding(.horizontal, 16)
        }
        .onAppear(perform: {
            mainViewModel.getLists()
        })
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                Button {
                    
                } label: {
                    HStack {
                        Image(systemName: IconNames.Objects.pencilSquare)
                        Text("Create new")
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
