//
//  SignInViewModel.swift
//  pokeapp
//
//  Created by MAC-097419 on 07/12/23.
//

import Foundation
import Firebase
import GoogleSignIn
import Combine

final class SignInViewModel: ObservableObject {
    @Published var isLoggedIn = false
    var loginError = PassthroughSubject<String, Never>()
    
    func onTappedSignInWithGoogle(withPresenting viewController: UIViewController) {
        guard let clientId = FirebaseApp.app()?.options.clientID else { return }
        
        let config = GIDConfiguration(clientID: clientId)
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: viewController) { [weak self] user, error in
            if let error = error {
                self?.loginError.send(error.localizedDescription)
                return
            }
            
            guard let user = user?.user, let idToken = user.idToken else { return }
            
            let accessToken = user.accessToken
            let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { result, error in
                if let error = error {
                    self?.loginError.send(error.localizedDescription)
                    return
                }
                
                guard result?.user != nil else { return }
                self?.isLoggedIn = true
            }
        }
    }
}
