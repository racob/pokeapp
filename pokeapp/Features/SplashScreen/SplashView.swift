//
//  SplashView.swift
//  pokeapp
//
//  Created by MAC-097419 on 06/12/23.
//

import SwiftUI

struct SplashView: View {
    @State private var isShowingSplashScreen = true
    
    var body: some View {
        if isShowingSplashScreen {
            ZStack {
                Color.primary800
                Image("PokemonLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 253, height: 112)
            }
            .ignoresSafeArea()
            .onAppear(perform: hideSplashScreen)
        } else {
            SignInView()
        }
    }
    
    private func hideSplashScreen() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            withAnimation {
                self.isShowingSplashScreen = false
            }
        }
    }
}

#Preview {
    SplashView()
}
