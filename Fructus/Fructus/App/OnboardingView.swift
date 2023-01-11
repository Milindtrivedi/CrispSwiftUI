//
//  OnboardingView.swift
//  Fructus
//
//  Created by Milind Trivedi on 06/09/22.
//

import SwiftUI

struct OnboardingView: View {
    
    //MARK: - Properties
    
    
    //MARK: - Body
    var body: some View {
        TabView {
            ForEach(0..<5) { value in
                
                FruitCardView()
            }
            
            
            
        } //: TAB
        .tabViewStyle(PageTabViewStyle())
        .padding(.vertical, 20)
        
    }
}

//MARK: - Preview
struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
