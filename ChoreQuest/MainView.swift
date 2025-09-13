//
//  ContentView.swift
//  ChoreQuest
//
//  Created by Leonardo Soares on 17/08/2025.
//

import SwiftUI

struct MainView: View {
    
    @State private(set) var toastViewModel = ToastViewModel()
    @State private(set) var mainViewModel = MainViewModel()
    @State private var currentIndex: Int = 0
    @State private var sheetIsPresented = false
    
    var body: some View {
        VStack {
            /**
             Cards view styling adapted from: https://medium.com/@kusalprabathrajapaksha/animated-carousel-view-swiftui-cee1954f0be7
             */
            if !mainViewModel.lists.isEmpty {
                GeometryReader { proxy in
                    ScrollView(.horizontal) {
                        LazyHStack(spacing: 10) {
                            ForEach(
                                Array(
                                    mainViewModel.lists.enumerated()
                                ),
                                id: \.offset
                            ) {
                                index,
                                item in
                                // TODO: - Adjustment for cards on portrait mode and iPad
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
                .scrollTargetBehavior(.viewAligned) // Align content behavior
                .onAppear(perform: {
                    mainViewModel.getLists()
                })
            } else {
                VStack {
                    Text("Empty box")
                        .font(.title)
                        .foregroundStyle(Color.gray.opacity(0.5))
                        .fontWeight(.bold)
                    Text("Create a new list on the button below")
                        .font(.title3)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(Color.gray.opacity(0.5))
                        .fontWeight(.bold)
                    Image(systemName: IconNames.Objects.archiveBox)
                        .font(.largeTitle)
                        .foregroundStyle(Color.gray.opacity(0.5))
                        .fontWeight(.bold)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
            
            Button {
                sheetIsPresented = true
            } label: {
                HStack {
                    Image(systemName: IconNames.Objects.pencilAndListClipboard)
                    Text("Create a new List")
                }
            }
            .buttonStyle(BlueButton())
        }
        .sheet(
            isPresented: $sheetIsPresented,
            content: {
                EditListView(
                    sheetIsPresented: $sheetIsPresented,
                    listingViewModel: ListingViewModel(title: "")
                )
                .environment(mainViewModel)
        })
        .background(Color.yellow)
        .environment(toastViewModel)
    }
}

#Preview {
    MainView()
}

struct BlueButton: ButtonStyle {
    @State private(set) var padding: CGFloat
    
    init(padding: CGFloat = 12) {
        self.padding = padding
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(padding)
            .background(Color(red: 0, green: 0, blue: 0.5))
            .foregroundStyle(.white)
            .clipShape(Capsule())
            .shadow(radius: 2, x: 2, y: 2)
    }
}
