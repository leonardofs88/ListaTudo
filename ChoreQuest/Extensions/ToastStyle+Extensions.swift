//
//  ToastStyle+Extensions.swift
//  ChoreQuest
//
//  Created by Leonardo Soares on 07/10/2025.
//

import SwiftUI

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
