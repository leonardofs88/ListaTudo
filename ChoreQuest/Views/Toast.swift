//
//  Toast.swift
//  ChoreQuest
//
//  Created by Leonardo Soares on 07/09/2025.
//

import SwiftUI

struct Toast: View {

    @State private(set) var toastViewModel: ToastViewModel

    var body: some View {
        VStack {
            Spacer()
            HStack(alignment: .center) {
                Image(systemName: toastViewModel.toastData.style.iconFileName)
                Spacer()
                Text(toastViewModel.toastData.message)
                Spacer()
            }
            .padding()
            .foregroundStyle(Color.white)
            .background(toastViewModel.toastData.style.themeColor)
            .cornerRadius(8)
        }
        .padding()
    }
}

#Preview {
    Toast(toastViewModel: ToastViewModel())
}

@Observable
class ToastViewModel {
    private(set) var toastData: ToastData = ToastData(
        style: .alert,
        message: "",
        duration: 6
    )
    private(set) var isToastPresented = false

    func setToast(_ toastData: ToastData) {
        self.toastData = toastData
    }

    func showToast() {
        isToastPresented = true
    }

    func hideToast() {
        isToastPresented = false
    }
}

struct ToastData: Equatable {
    var style: ToastStyle
    var message: String
    var duration: Double
}

enum ToastStyle {
    case info
    case error
    case success
    case alert
}
extension ToastStyle {

    var themeColor: Color {
        switch self {
        case .error: return Color.red
        case .alert: return Color.orange
        case .info: return Color.blue
        case .success: return Color.green
        }
    }

    var iconFileName: String {
        switch self {
        case .info: return "info.circle.fill"
        case .alert: return "exclamationmark.triangle.fill"
        case .success: return "checkmark.circle.fill"
        case .error: return "xmark.circle.fill"
        }
    }
}

extension View {
    func toast(viewModel: ToastViewModel) -> some View {
        self
            .modifier(ToastModifier(toastViewModel: viewModel))
    }
}

struct ToastModifier: ViewModifier {
    
    @State private(set) var toastViewModel: ToastViewModel
    @State private var workItem: DispatchWorkItem?
    
    func body(content: Content) -> some View {
        content
            .overlay(
              ZStack {
                  if toastViewModel.isToastPresented {
                      Toast(toastViewModel: toastViewModel)
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
        withAnimation {
            toastViewModel.hideToast()
        }
        
        workItem?.cancel()
        workItem = nil
      }
}
