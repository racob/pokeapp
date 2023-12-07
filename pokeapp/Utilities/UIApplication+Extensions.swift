//
//  AppUtility.swift
//  pokeapp
//
//  Created by MAC-097419 on 07/12/23.
//

import SwiftUI
import UIKit

extension UIApplication {
    var rootViewController: UIViewController {
        guard let screen = connectedScenes.first as? UIWindowScene,
              let root = screen.windows.first?.rootViewController
        else { return .init() }
        return root
    }
}

