//
//  FructusApp.swift
//  Fructus
//
//  Created by Milind Trivedi on 06/09/22.
//

import SwiftUI

@main
struct FructusApp: App {

    @AppStorage("isOnboarding") var isOnboarding : Bool = true
    
    var body: some Scene {
        WindowGroup {
            if isOnboarding {
                OnboardingView()
            } else {
                ContentView()
            }
        }
    }
}
