//
//  ContentView.swift
//  InternZee
//
//  Created by Milind Trivedi on 02/09/22.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("onboarding") var isOnboardingViewActive : Bool = true
    
    @ObservedObject var dm = NetworkManager()
    
    var body: some View {
        ZStack{
            if isOnboardingViewActive {
                OnboardingView()
            } else {
                HomeView()
            }
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
