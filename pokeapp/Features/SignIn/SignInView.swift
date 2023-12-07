//
//  SignInView.swift
//  pokeapp
//
//  Created by MAC-097419 on 07/12/23.
//

import SwiftUI
import GoogleSignInSwift

struct SignInView: View {
    @StateObject private var viewModel = SignInViewModel()
    @State private var showErrorAlert = false
    @State private var errorMessage = ""
    
    var body: some View {
        ZStack {
            Color.primary800
            VStack {
                Image("PokemonLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 253, height: 112)
                Spacer().frame(height: 192)
                GoogleSignInButton {
                    let viewController = UIApplication.shared.rootViewController
                    viewModel.onTappedSignInWithGoogle(withPresenting: viewController)
                }.frame(width: 220)
            }
        }
        .ignoresSafeArea()
        .alert(isPresented: $showErrorAlert, content: errorAlert)
        .onReceive(viewModel.loginError) { errorMessage in
            self.errorMessage = errorMessage
            self.showErrorAlert = true
        }
        .fullScreenCover(isPresented: $viewModel.isLoggedIn) {
            PokeListView()
        }
    }
    
    private func errorAlert() -> Alert {
        Alert(
            title: Text("Login Error"),
            message: Text(errorMessage),
            dismissButton: .default(Text("OK"))
        )
    }
}

#Preview {
    SignInView()
}
