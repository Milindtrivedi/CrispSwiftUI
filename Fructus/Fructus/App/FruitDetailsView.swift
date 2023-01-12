//
//  FruitDetailsView.swift
//  Fructus
//
//  Created by Apple on 12/01/23.
//

import SwiftUI

struct FruitDetailsView: View {
    //MARK: - PROPERTIES
    var fruit: Fruit
    
    
    //MARK: - BODY
    var body: some View {
        Text(fruit.title)
    }
}
//MARK: - PREVIEW
struct FruitDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        FruitDetailsView(fruit: fruitsData[0])
    }
}
