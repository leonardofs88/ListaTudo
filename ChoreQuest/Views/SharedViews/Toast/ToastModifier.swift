//
//  ToastModifier.swift
//  ChoreQuest
//
//  Created by Leonardo Soares on 07/10/2025.
//

import SwiftUI

struct ToastModifier: ViewModifier {
    @Environment(\.toastViewModel) private var toastViewModel
    @State private var workItem: DispatchWorkItem?
    
    func body(content: Content) -> some View {
        content
            .overlay(
                ZStack {
                    if toastViewModel.isToastPresented {
                        Toast()
                            .offset(y: -50)
                    }
                }.animation(.spring(), value: toastViewModel.isToastPresented)
            )
            .onChange(of: toastViewModel.isToastPresented) { oldValue, value in
                if value {
                    showToast()
                }
            }
    }
    
    private func showToast() {
        UIImpactFeedbackGenerator(style: .light)
            .impactOccurred()
        
        if toastViewModel.toastData.duration > 0 {
            workItem?.cancel()
            
            let task = DispatchWorkItem {
                dismissToast()
            }
            
            workItem = task
            DispatchQueue.main.asyncAfter(deadline: .now() + toastViewModel.toastData.duration, execute: task)
        }
    }
    
    private func dismissToast() {
        withAnimation(.bouncy) {
            toastViewModel.hideToast()
        }
        
        workItem?.cancel()
        workItem = nil
    }
}
