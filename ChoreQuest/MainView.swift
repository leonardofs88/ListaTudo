//
//  ContentView.swift
//  ChoreQuest
//
//  Created by Leonardo Soares on 17/08/2025.
//

import SwiftUI

struct MainView: View {
    @Namespace var editNamespace
    
    @State private(set) var toastViewModel = ToastViewModel()
    @State private(set) var mainViewModel = MainViewModel()
    @State private var editViewPresented = false
    
    var body: some View {
        ZStack {
            if !editViewPresented {
                CardListingView(editViewPresented: $editViewPresented, editNamespace: editNamespace)
            } else  {
                EditListView($editViewPresented)
                .matchedGeometryEffect(
                    id: "sheet",
                    in: editNamespace,
                    properties: .position
                )
            }
        }
        .background(Color.yellow)
        .environment(toastViewModel)
        .environment(mainViewModel)
    }
}

#Preview {
    MainView()
}

struct CardListingView: View {
    
    @Environment(\.mainViewModel) private var mainViewModel
    
    @Binding private(set) var editViewPresented: Bool
    
    var editNamespace: Namespace.ID
    
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
                                    ChoreListingView(
                                        listingViewModel: item
                                    )
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
                    .task {
                        await mainViewModel.getLists()
                    }
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
                    withAnimation(.linear(duration: 0.3)) {
                        editViewPresented = true
                    }
                } label: {
                    HStack {
                        Image(systemName: IconNames.Objects.pencilAndListClipboard)
                        Text("Create a new List")
                    }
                }
                .matchedGeometryEffect(
                    id: "sheet",
                    in: editNamespace,
                    properties: .position
                )
                .transition(
                    .asymmetric(
                        insertion: .move(edge: .top),
                        removal: .move(edge: .bottom)
                    )
                )
                .buttonStyle(ChoreQuestButtonStyle())
            }
    }
}
