//
//  NavigationBackButton.swift
//  pokeapp
//
//  Created by MAC-097419 on 07/12/23.
//

import SwiftUI

struct NavigationBackButton: View {
    @Environment(\.presentationMode) var presentation
    private let label: String
    
    init(label: String) {
        self.label = label
    }
    
    var body: some View {
        Button {
            presentation.wrappedValue.dismiss()
        } label: {
            HStack {
                Text(Image(systemName: "chevron.left")).bold()
                Text(label)
            }.tint(.primary800)
        }
    }
}

#Preview {
    NavigationBackButton(label: "This is Back Button")
}
