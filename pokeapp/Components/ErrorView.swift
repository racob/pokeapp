//
//  ErrorView.swift
//  pokeapp
//
//  Created by MAC-097419 on 07/12/23.
//

import SwiftUI

struct ErrorView: View {
    var onTappedRetry: (() -> Void)?
    
    var body: some View {
        ZStack {
            Color.light800.ignoresSafeArea()
            VStack {
                Image(systemName: "xmark.icloud")
                    .foregroundStyle(.secondary800)
                    .font(.system(size: 100))
                Text("Oops... something went wrong").padding()
                Button {
                    onTappedRetry?()
                } label: {
                    HStack(spacing: 10) {
                        Image(systemName: "arrow.clockwise")
                        Text("Retry").fontWeight(.semibold)
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(
                        RoundedRectangle(
                            cornerRadius: 20,
                            style: .continuous
                        )
                        .fill(.primary800)
                    )
                }
            }
        }
    }
}

#Preview {
    ErrorView()
}
