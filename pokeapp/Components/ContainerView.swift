//
//  ContainerView.swift
//  pokeapp
//
//  Created by MAC-097419 on 07/12/23.
//

import SwiftUI

struct ContainerView<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .foregroundStyle(.light800)
            .background(RoundedRectangle(cornerRadius: 10).fill(.primary800))
    }
}

#Preview {
    ContainerView {
        Text("Test").padding()
    }
}
