//
//  OnboardingView.swift
//  Fructus
//
//  Created by Milind Trivedi on 06/09/22.
//

import SwiftUI

struct OnboardingView: View {
    
    //MARK: - Properties
    var fruits : [Fruit] = fruitsData
    
    
    //MARK: - Body
    var body: some View {
        TabView {
            ForEach(fruits[0...5]) { value in
                FruitCardView(fruit: value)
            }
        } //: TAB
        .tabViewStyle(PageTabViewStyle())
        .padding(.vertical, 20)
        
    }
}

//MARK: - Preview
struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(fruits: fruitsData)
    }
}
