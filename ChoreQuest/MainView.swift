//
//  ContentView.swift
//  ChoreQuest
//
//  Created by Leonardo Soares on 17/08/2025.
//

import SwiftUI

struct MainView: View {
    
    @Namespace var mainNamespace
    
    @State private(set) var toastViewModel = ToastViewModel()
    @State private(set) var mainViewModel = MainViewModel()
    @State private var editViewPresented = false
    
    var body: some View {
        ZStack {
            if !editViewPresented {
                CardListingView(editViewPresented: $editViewPresented, animation: mainNamespace)
            } else  {
                EditListView($editViewPresented)
                .matchedGeometryEffect(
                    id: "sheet",
                    in: mainNamespace,
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
