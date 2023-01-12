//
//  ContentView.swift
//  Fructus
//
//  Created by Milind Trivedi on 06/09/22.
//

import SwiftUI

struct ContentView: View {
    // MARK: - PROPERTIES
    
    var fruits: [Fruit] = fruitsData
    
    // MARK: - BODY
    var body: some View {
        
        NavigationView {
            
            List {
                ForEach(fruits.shuffled()) { fruit in
                    
                    NavigationLink(destination: FruitDetailsView(fruit: fruit)) {
                        FruitRowView(fruit: fruit)
                            .padding(.vertical, 4)
                    }
                    
                }
            }
            .listStyle(.plain)
            
            .navigationTitle("Fruits")
        } //: NAVIGATION
    }
}


// MARK: - PREVIEW

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(fruits: fruitsData)
        .previewDevice ("iPhone 11 Pro")
    }
}
