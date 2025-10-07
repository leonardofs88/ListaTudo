//
//  ToastViewModel.swift
//  ChoreQuest
//
//  Created by Leonardo Soares on 07/10/2025.
//

import SwiftUI

@Observable
class ToastViewModel: ToastViewModelProtocol {
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
