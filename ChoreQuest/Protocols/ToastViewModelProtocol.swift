//
//  ToastViewModelProtocol.swift
//  ChoreQuest
//
//  Created by Leonardo Soares on 07/10/2025.
//

import SwiftUI

protocol ToastViewModelProtocol: Observable {
    var toastData: ToastData { get }
    var isToastPresented: Bool { get }
    func setToast(_ toastData: ToastData)
    func showToast()
    func hideToast()
}

struct ToastViewModelKey: EnvironmentKey {
    static let defaultValue: any ToastViewModelProtocol = ToastViewModel()
}

extension EnvironmentValues {
    var toastViewModel: any ToastViewModelProtocol {
        get { self[ToastViewModelKey.self] }
        set { self[ToastViewModelKey.self] = newValue }
    }
}
