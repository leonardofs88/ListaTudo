//
//  Toast.swift
//  ChoreQuest
//
//  Created by Leonardo Soares on 07/09/2025.
//

import SwiftUI

struct Toast: View {
    @Environment(\.toastViewModel) private var toastViewModel

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
    Toast()
        .environment(ToastViewModel())
}


